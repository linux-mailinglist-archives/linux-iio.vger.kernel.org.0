Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9603D38D6BC
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 19:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhEVR4t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 13:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhEVR4s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 13:56:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CF361073;
        Sat, 22 May 2021 17:55:19 +0000 (UTC)
Date:   Sat, 22 May 2021 18:56:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH 4/8] iio: accel: bmc150: Add support for
 dual-accelerometers with a DUAL250E HID
Message-ID: <20210522185642.0b65daed@jic23-huawei>
In-Reply-To: <3273a327-2b25-8b42-6870-e09982125119@redhat.com>
References: <20210521171418.393871-1-hdegoede@redhat.com>
        <20210521171418.393871-5-hdegoede@redhat.com>
        <20210522184336.09c219cd@jic23-huawei>
        <3273a327-2b25-8b42-6870-e09982125119@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 May 2021 19:44:55 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 5/22/21 7:43 PM, Jonathan Cameron wrote:
> > On Fri, 21 May 2021 19:14:14 +0200
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >   
> >> The Lenovo Yoga 300-11IBR has a ACPI fwnode with a HID of DUAL250E
> >> which contains I2C and IRQ resources for 2 accelerometers, 1 in the
> >> display and one in the base of the device. Add support for this.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  drivers/iio/accel/bmc150-accel-i2c.c | 19 ++++++++++++-------
> >>  1 file changed, 12 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> >> index e24ce28a4660..b81e4005788e 100644
> >> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> >> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> >> @@ -24,6 +24,7 @@
> >>  #ifdef CONFIG_ACPI
> >>  static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
> >>  	{"BOSC0200"},
> >> +	{"DUAL250E"},
> >>  	{ },
> >>  };
> >>  
> >> @@ -35,21 +36,24 @@ static void bmc150_acpi_dual_accel_probe(struct i2c_client *client)
> >>  {
> >>  	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
> >>  	struct i2c_client *second_dev;
> >> +	char dev_name[16];  
> > 
> > I'm a bit in two minds about having a fixed length array for this.
> > Obviously this is always big enough (I think a bit too big), but it
> > might be a place where a future bug is introduced.  Perhaps it's worth the dance
> > of a kasprintf and kfree, to avoid that possibility?  
> 
> I would prefer to keep this as is, using malloc + free always leads
> to problems if an error-exit path shows up between the 2.
> 
> But if you've a strong preference for switching to
> kasprintf + kfree I can do that for v2.

Lets leave it as is and I get to be smug if we ever get a bug as a result
(given that way the one you suggest can't happen, so I can't be proved wrong :)

J
> 
> Regards,
> 
> Hans
> 
> 
> 
> >   
> >>  	struct i2c_board_info board_info = {
> >>  		.type = "bmc150_accel",
> >> -		/*
> >> -		 * The 2nd accel sits in the base of 2-in-1s. Note this
> >> -		 * name is static, as there should never be more then 1
> >> -		 * BOSC0200 ACPI node with 2 accelerometers in it.
> >> -		 */
> >> -		.dev_name = "BOSC0200:base",
> >> +		.dev_name = dev_name,
> >>  		.fwnode = client->dev.fwnode,
> >> -		.irq = -ENOENT,
> >>  	};
> >>  
> >>  	if (acpi_match_device_ids(adev, bmc150_acpi_dual_accel_ids))
> >>  		return;
> >>  
> >> +	/*
> >> +	 * The 2nd accel sits in the base of 2-in-1s. The suffix is static, as
> >> +	 * there should never be more then 1 ACPI node with 2 accelerometers in it.
> >> +	 */
> >> +	snprintf(dev_name, sizeof(dev_name), "%s:base", acpi_device_hid(adev));
> >> +
> >> +	board_info.irq = acpi_dev_gpio_irq_get_by(adev, NULL, 1);
> >> +
> >>  	second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
> >>  	if (!IS_ERR(second_dev))
> >>  		bmc150_set_second_device(client, second_dev);
> >> @@ -114,6 +118,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
> >>  	{"BMA222E",	bma222e},
> >>  	{"BMA0280",	bma280},
> >>  	{"BOSC0200"},
> >> +	{"DUAL250E"},
> >>  	{ },
> >>  };
> >>  MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);  
> >   
> 


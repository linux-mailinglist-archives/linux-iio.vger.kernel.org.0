Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14E42B2F1E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 18:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgKNRe7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 12:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgKNRe6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 12:34:58 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B06AF221F9;
        Sat, 14 Nov 2020 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605375297;
        bh=pTrrfDd1iPUxzzFpHHfEZTA391kzME2SXU1TEk5rCE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=My5viOhtDbaKXo8jRDFTj9clDB3W1KFbIYS1pTx7TTQ3QE/ol5o80cViZa3MBabv9
         OPzO376uNmle4qZa2obQvoF98d+6oTlOlwKYLIhfB5VbDu+raHnwvVoaUuMsfhHkCx
         l7xtyWw4LNyQJo7GbATozesWjs1NX3MNmaXyJt1c=
Date:   Sat, 14 Nov 2020 17:34:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH bugfix for 5.10 2/2] iio: accel: kxcjk1013: Add support
 for KIOX010A ACPI DSM for setting tablet-mode
Message-ID: <20201114173453.04e14a19@archlinux>
In-Reply-To: <196bd93a-b005-e7fd-4db1-138934080ec8@redhat.com>
References: <20201110133835.129080-1-hdegoede@redhat.com>
        <20201110133835.129080-3-hdegoede@redhat.com>
        <20201114160118.0a373496@archlinux>
        <196bd93a-b005-e7fd-4db1-138934080ec8@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Nov 2020 18:07:38 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 11/14/20 5:01 PM, Jonathan Cameron wrote:
> > On Tue, 10 Nov 2020 14:38:35 +0100
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >   
> >> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 KXCJ91008-s
> >> to allow the OS to determine the angle between the display and the base
> >> of the device, so that the OS can determine if the 2-in-1 is in laptop
> >> or in tablet-mode.
> >>
> >> On Windows both accelerometers are read by a special HingeAngleService
> >> process; and this process calls a DSM (Device Specific Method) on the
> >> ACPI KIOX010A device node for the sensor in the display, to let the
> >> embedded-controller (EC) know about the mode so that it can disable the
> >> kbd and touchpad to avoid spurious input while folded into tablet-mode.
> >>
> >> This notifying of the EC is problematic because sometimes the EC comes up
> >> thinking that device is in tablet-mode and the kbd and touchpad do not
> >> work. This happens for example on Irbis NB111 devices after a suspend /
> >> resume cycle (after a complete battery drain / hard reset without having
> >> booted Windows at least once). Other 2-in-1s which are likely affected
> >> too are e.g. the Teclast F5 and F6 series.
> >>
> >> The kxcjk-1013 driver may seem like a strange place to deal with this,
> >> but since it is *the* driver for the ACPI KIOX010A device, it is also
> >> the driver which has access to the ACPI handle needed by the DSM.
> >>
> >> Add support for calling the DSM and on probe unconditionally tell the
> >> EC that the device is laptop mode, fixing the kbd and touchpad sometimes
> >> not working.
> >>
> >> Reported-and-tested-by: russianneuromancer <russianneuromancer@ya.ru>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
> > Hi Hans,
> > 
> > *Mutters darkly about crazy firmware hacks*
> > 
> > I'm fine taking this but I assume we want to backport and for that I'm
> > after a fixes tag.  
> 
> Good point, I guess taking the commit which originally added the
> KIOX010A ACPI Hardware-ID makes the most sense:
> 
> Fixes: 7f6232e69539 ("iio: accel: kxcjk1013: Add KIOX010A ACPI Hardware-ID")

Agreed.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> Regards,
> 
> Hans
> 
> 
> 
> >> ---
> >>  drivers/iio/accel/kxcjk-1013.c | 36 ++++++++++++++++++++++++++++++++++
> >>  1 file changed, 36 insertions(+)
> >>
> >> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> >> index abeb0d254046..560a3373ff20 100644
> >> --- a/drivers/iio/accel/kxcjk-1013.c
> >> +++ b/drivers/iio/accel/kxcjk-1013.c
> >> @@ -129,6 +129,7 @@ enum kx_chipset {
> >>  enum kx_acpi_type {
> >>  	ACPI_GENERIC,
> >>  	ACPI_SMO8500,
> >> +	ACPI_KIOX010A,
> >>  };
> >>  
> >>  struct kxcjk1013_data {
> >> @@ -275,6 +276,32 @@ static const struct {
> >>  			      {19163, 1, 0},
> >>  			      {38326, 0, 1} };
> >>  
> >> +#ifdef CONFIG_ACPI
> >> +enum kiox010a_fn_index {
> >> +	KIOX010A_SET_LAPTOP_MODE = 1,
> >> +	KIOX010A_SET_TABLET_MODE = 2,
> >> +};
> >> +
> >> +static int kiox010a_dsm(struct device *dev, int fn_index)
> >> +{
> >> +	acpi_handle handle = ACPI_HANDLE(dev);
> >> +	guid_t kiox010a_dsm_guid;
> >> +	union acpi_object *obj;
> >> +
> >> +	if (!handle)
> >> +		return -ENODEV;
> >> +
> >> +	guid_parse("1f339696-d475-4e26-8cad-2e9f8e6d7a91", &kiox010a_dsm_guid);
> >> +
> >> +	obj = acpi_evaluate_dsm(handle, &kiox010a_dsm_guid, 1, fn_index, NULL);
> >> +	if (!obj)
> >> +		return -EIO;
> >> +
> >> +	ACPI_FREE(obj);
> >> +	return 0;
> >> +}
> >> +#endif
> >> +
> >>  static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
> >>  			      enum kxcjk1013_mode mode)
> >>  {
> >> @@ -352,6 +379,13 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
> >>  {
> >>  	int ret;
> >>  
> >> +#ifdef CONFIG_ACPI
> >> +	if (data->acpi_type == ACPI_KIOX010A) {
> >> +		/* Make sure the kbd and touchpad on 2-in-1s using 2 KXCJ91008-s work */
> >> +		kiox010a_dsm(&data->client->dev, KIOX010A_SET_LAPTOP_MODE);
> >> +	}
> >> +#endif
> >> +
> >>  	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_WHO_AM_I);
> >>  	if (ret < 0) {
> >>  		dev_err(&data->client->dev, "Error reading who_am_i\n");
> >> @@ -1262,6 +1296,8 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
> >>  
> >>  	if (strcmp(id->id, "SMO8500") == 0)
> >>  		*acpi_type = ACPI_SMO8500;
> >> +	else if (strcmp(id->id, "KIOX010A") == 0)
> >> +		*acpi_type = ACPI_KIOX010A;
> >>  
> >>  	*chipset = (enum kx_chipset)id->driver_data;
> >>    
> >   
> 


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72D91CCA84
	for <lists+linux-iio@lfdr.de>; Sun, 10 May 2020 13:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgEJLAW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 07:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgEJLAW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 May 2020 07:00:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70A1F20708;
        Sun, 10 May 2020 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589108421;
        bh=y6Q7eSTVZ1KzZiuOCrv0FQwCH4hWBWN3Tp4Umxf+9W8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NnfImhX7HKPftayZYG9B2Q1EKNznqqfYZTsww3lfw3LQ+FdmCHYB5R/96Ju+SLww1
         f4vzU5fE3bFiOSOlWXZL7qcnJKD93o3YWi4t+WOgNkYH7y3vZz+6JcJ0MYby4YehTl
         5u+PGAxSoPGDWmmUJxiEFDmneOTUHTeEK6P4oJZQ=
Date:   Sun, 10 May 2020 12:00:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 01/11] iio: light: cm32181: Switch to new style
 i2c-driver probe function
Message-ID: <20200510120016.7b360d81@archlinux>
In-Reply-To: <e30bbcb4-c0cd-e95f-501a-89270f8dd19e@redhat.com>
References: <20200504125551.434647-1-hdegoede@redhat.com>
        <20200510104806.63ffeae5@archlinux>
        <e30bbcb4-c0cd-e95f-501a-89270f8dd19e@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 May 2020 12:03:08 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 5/10/20 11:48 AM, Jonathan Cameron wrote:
> > On Mon,  4 May 2020 14:55:41 +0200
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >   
> >> Switch to the new style i2c-driver probe_new probe function and drop the
> >> unnecessary i2c_device_id table (we do not have any old style board files
> >> using this).
> >>
> >> This is a preparation patch for adding ACPI binding support.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
> > Hi Hans,
> > 
> > Seems these have all been sent with mime type of quoted-printable.
> > As git am really doesn't like that I ended up pulling these down from
> > patchwork.
> > 
> > Please try and sort that email issue out for future patch sets until
> > we get git am that works with it in standard distro packages (assuming
> > it ever does)  
> 
> Weird, I used git send-email to send the patches, as I always do.
> I contribute to a lot of subsystems and this is the first complaint I'm
> getting about this ?
It's not been true of the previous ones you've sent me.

A bit of googling suggests git-send-email will do this if it finds a CR
in the patch.  Perhaps that's what happened?

Maybe try sending them one at a time and see if a particular patch is causing
it to happen.  Then play detective on why.

Or just take it as one of those things and ignore it unless it happens again!

J

> 
> > Otherwise, a bit of fuzz from the patch that dropped the of_match_ptr
> > protections.
> > 
> > Series applied to the togreg branch of iio.git and pushed out as testing for
> > the autobuilders to play with it.  
> 
> Great, thank you.
> 
> Regards,
> 
> Hans
> 
> 
> 
> >> ---
> >> Changes in v4:
> >> - Set indio_dev->name to "cm32181" instead of setting it to dev_name(dev)
> >>
> >> Changes in v3:
> >> - This is a new patch in v3 of this patch-set
> >> ---
> >>   drivers/iio/light/cm32181.c | 15 +++------------
> >>   1 file changed, 3 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> >> index 5f4fb5674fa0..2c139d85ef0c 100644
> >> --- a/drivers/iio/light/cm32181.c
> >> +++ b/drivers/iio/light/cm32181.c
> >> @@ -294,8 +294,7 @@ static const struct iio_info cm32181_info = {
> >>   	.attrs			= &cm32181_attribute_group,
> >>   };
> >>   
> >> -static int cm32181_probe(struct i2c_client *client,
> >> -			const struct i2c_device_id *id)
> >> +static int cm32181_probe(struct i2c_client *client)
> >>   {
> >>   	struct cm32181_chip *cm32181;
> >>   	struct iio_dev *indio_dev;
> >> @@ -316,7 +315,7 @@ static int cm32181_probe(struct i2c_client *client,
> >>   	indio_dev->channels = cm32181_channels;
> >>   	indio_dev->num_channels = ARRAY_SIZE(cm32181_channels);
> >>   	indio_dev->info = &cm32181_info;
> >> -	indio_dev->name = id->name;
> >> +	indio_dev->name = "cm32181";
> >>   	indio_dev->modes = INDIO_DIRECT_MODE;
> >>   
> >>   	ret = cm32181_reg_init(cm32181);
> >> @@ -338,13 +337,6 @@ static int cm32181_probe(struct i2c_client *client,
> >>   	return 0;
> >>   }
> >>   
> >> -static const struct i2c_device_id cm32181_id[] = {
> >> -	{ "cm32181", 0 },
> >> -	{ }
> >> -};
> >> -
> >> -MODULE_DEVICE_TABLE(i2c, cm32181_id);
> >> -
> >>   static const struct of_device_id cm32181_of_match[] = {
> >>   	{ .compatible = "capella,cm32181" },
> >>   	{ }
> >> @@ -356,8 +348,7 @@ static struct i2c_driver cm32181_driver = {
> >>   		.name	= "cm32181",
> >>   		.of_match_table = of_match_ptr(cm32181_of_match),
> >>   	},
> >> -	.id_table       = cm32181_id,
> >> -	.probe		= cm32181_probe,
> >> +	.probe_new	= cm32181_probe,
> >>   };
> >>   
> >>   module_i2c_driver(cm32181_driver);  
> >   
> 


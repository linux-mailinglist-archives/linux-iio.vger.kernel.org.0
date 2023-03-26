Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F446C96B8
	for <lists+linux-iio@lfdr.de>; Sun, 26 Mar 2023 18:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjCZQLN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Mar 2023 12:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZQLN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2023 12:11:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E8846BC;
        Sun, 26 Mar 2023 09:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47F9BB80D17;
        Sun, 26 Mar 2023 16:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A2CC433EF;
        Sun, 26 Mar 2023 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679847067;
        bh=o9DhWBV3PlIK120tOC+Wz+SCIfbOtFOcA2xWJ2t7RJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IJCflRmAEhIDBBRjbWju3AVqZdbIpitpI7cGgyoxGpDZ2VKFhwjNh1LJiIwjF2Ie/
         E0I0D3O7KM+EI4NZlcfyJ5/3fSVQslIc3R8VBm8H5WGfXdnywPsvC510F4+qfoysNY
         5NCrNrtIMclXrOf2NatTSjK+pbxk3AL0pFST34qeNEzGpV1qsYKYxC+XfpxTLe2rAw
         UjJw0Mzw1hnFbGbC2fvDTbahJtyzRH+VpHQxzgnd8sDSTow9XbXcSRTlPBIwyFj6AS
         28P4VBCD3BIgU/KFTBbMILtW3HVsRcM7m9YR9vj3qsmjzusf2qwz47nii6fmv1vcph
         0LU8vG+DIu0fQ==
Date:   Sun, 26 Mar 2023 17:26:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrew Hepp <andrew.hepp@ahepp.dev>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] iio: temperature: Add MCP9600 thermocouple EMF
 converter
Message-ID: <20230326172610.55db8cff@jic23-huawei>
In-Reply-To: <59c33dc5-bc97-8016-72cf-e56c73943eda@ahepp.dev>
References: <20230319184728.49232-1-andrew.hepp@ahepp.dev>
        <20230319184728.49232-3-andrew.hepp@ahepp.dev>
        <89271a29-5b02-34fe-409b-373e3b8044ef@metafoo.de>
        <59c33dc5-bc97-8016-72cf-e56c73943eda@ahepp.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Mar 2023 11:20:55 -0700
Andrew Hepp <andrew.hepp@ahepp.dev> wrote:

> On 3/19/23 11:59 AM, Lars-Peter Clausen wrote:
> > This looks really good. I have some small comments, and I apologize for=
=20
> > only having them so late in the review cycle. =20
>=20
> No worries at all! I really appreciate the time and effort you,=20
> Jonathan, and Krzysztof have put into reviewing this.
>=20
> >=20
> > On 3/19/23 11:47, Andrew Hepp wrote: =20
> >> Add support for the MCP9600 thermocouple EMF converter. =20
> >=20
> > Would be nice to have a very short description of the capabilities of=20
> > the sensor in the commit message.
> >  =20
>=20
> That seems like a good idea! Should the message be about the=20
> capabilities of the sensor, or the capabilities of the driver? The=20
> sensor supports a lot of advanced features that the driver currently=20
> doesn't support.
>=20
> Currently I'm leaning towards
>=20
> "Add support for the MCP9600 thermocouple EMF converter. The sensor has=20
> integrated cold junction compensation and a typical accuracy of 0.5=20
> degrees Celsius. The driver supports a resolution of 0.0625 degrees=20
> Celsius."
>=20

Might be worth calling out what EMF stands for as well.
Otherwise that is fine.


One follow up below. I took another look at the driver and other than the
points Lars has raised, this looks good to me now.

Thanks,

Jonathan


> >>
> >> Datasheet:=20
> >> https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20=
005426.pdf
> >> Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>
> >> ---
> >> [...]
> >> diff --git a/drivers/iio/temperature/mcp9600.c=20
> >> b/drivers/iio/temperature/mcp9600.c
> >> new file mode 100644
> >> index 000000000000..b6d8ffb90c36
> >> --- /dev/null
> >> +++ b/drivers/iio/temperature/mcp9600.c
> >> @@ -0,0 +1,145 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> [...]
> >> +static const struct iio_chan_spec mcp9600_channels[] =3D {
> >> +=C2=A0=C2=A0=C2=A0 {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D IIO_TEMP,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .address =3D MCP9600_HOT_J=
UNCTION,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .info_mask_separate =3D
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BI=
T(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> >> +=C2=A0=C2=A0=C2=A0 },
> >> +=C2=A0=C2=A0=C2=A0 {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D IIO_TEMP,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .address =3D MCP9600_COLD_=
JUNCTION,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .channel2 =3D IIO_MOD_TEMP=
_AMBIENT,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .modified =3D 1,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .info_mask_separate =3D
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BI=
T(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> >> +=C2=A0=C2=A0=C2=A0 },
> >> +=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(2), =20
> > If you do not have supported for buffered capture there is no need to=20
> > include a timestamp in the channel spec. There is no way to read it=20
> > without buffered support. =20
>=20
> Ack
>=20
> >> +};
> >> +
> >> +struct mcp9600_data {
> >> +=C2=A0=C2=A0=C2=A0 struct i2c_client *client;
> >> +=C2=A0=C2=A0=C2=A0 struct mutex read_lock; /* lock to prevent concurr=
ent reads */
> >> +};
> >> +
> >> +static int mcp9600_read(struct mcp9600_data *data,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct iio_chan_spec const *chan, int *val)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 __be16 buf; =20
> > buf does not seem to be used. =20
>=20
> Oops, sorry about that, I'll make sure to build with warnings as errors=20
> next submission. I tested the module after changing from=20
> i2c_smbus_read_block_data but looks like I got a bit ahead of myself=20
> submitting.
>=20
> >> +=C2=A0=C2=A0=C2=A0 int ret; >> +
> >> +=C2=A0=C2=A0=C2=A0 mutex_lock(&data->read_lock); =20
> > Do you actually need the custom lock? i2c_smbus_read_word_swapped itsel=
f=20
> > should provide locking and there is only a single operation under your=
=20
> > custom lock, which will already be atomic. =20
>=20
> That seems like a convincing argument to me. It certainly doesn't seem=20
> like the lock is doing anything, since i2c_smbus_read_word_swapped=20
> provides locking.
>=20
> >> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_read_word_swapped(data->client, =
chan->address);
> >> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&data->read_lock);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >> +=C2=A0=C2=A0=C2=A0 *val =3D ret;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 return 0;
> >> +}
> >> +
> >> [...]
> >> +static int mcp9600_probe(struct i2c_client *client)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev;
> >> +=C2=A0=C2=A0=C2=A0 struct mcp9600_data *data;
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_read_byte_data(client, MCP9600_D=
EVICE_ID);
> >> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
> >=20
> > Might as well throw an error message in here for better diagnostics.
> >=20
> >  =C2=A0=C2=A0=C2=A0 return dev_err_probe(&client->dev, ret, "Failed to =
read device ID\n");
> >=20
> >  =20
>=20
> I think this is how I did it in my original submission, but it sounds=20
> like the preferred way of doing things is to warn without returning an=20
> error, in order to support fallback compatibilities?

A failure to read the DEVICE_ID register at all is worth a print as this
is the first time the driver will try to use the bus so if the device isn't
there (or isn't responding) it would be good to shout about it.

Jonathan




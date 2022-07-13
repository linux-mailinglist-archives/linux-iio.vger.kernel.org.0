Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C09573B1A
	for <lists+linux-iio@lfdr.de>; Wed, 13 Jul 2022 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiGMQYP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Jul 2022 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiGMQYN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jul 2022 12:24:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE682D1F2
        for <linux-iio@vger.kernel.org>; Wed, 13 Jul 2022 09:24:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C4D61B40
        for <linux-iio@vger.kernel.org>; Wed, 13 Jul 2022 16:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A426DC34114;
        Wed, 13 Jul 2022 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657729451;
        bh=SV7xGYzXdrEmTVeWqgISpzyk43pYTe94PH0RwVFsXzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ah6Bxq0+FPIWlDoHyWT6mHlQabEYuLX4xBdu2e7qKNHm9leMpyVyxeKUYDbUNH2++
         kGkwcobbsObG5Y5XgPnZl1qQGpGVqPp0D2yTYSa0jf9Ui3w7DUtZ32ypNtynxte/0+
         Ci83fADy8mxhhcarJ6Hty9RpeA/VJqXdsByEvmZlgJ0CUxesCSG8tOGXv+WSFEO/I8
         HhvI+3z11LwV1xnx2CCrgBdWrTlVpsoUYg4uRCrkZAVv/I3szS5Fl4aYGlUix+SYWN
         Kn6ialv32kPq6gGmmC4xFks05MZOsBfmQgVlGpe0qLBKtxVROdc+Qz6VTTOtU3TCWe
         T3/aDX7zxsSOw==
Date:   Wed, 13 Jul 2022 17:34:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [RFC] iio: afe: rescale: Add support for converting scale avail
 table
Message-ID: <20220713173401.6e648444@jic23-huawei>
In-Reply-To: <20220711193714.50314-1-paul@crapouillou.net>
References: <20220711193714.50314-1-paul@crapouillou.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Jul 2022 20:37:14 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> When the IIO channel has a scale_available attribute, we want the values
> contained to be properly converted the same way the scale value is.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/afe/iio-rescale.c   | 75 +++++++++++++++++++++++++++++++++
>  include/linux/iio/afe/rescale.h |  2 +
>  2 files changed, 77 insertions(+)
>=20
>=20
>  Hi Jonathan,
>=20
>  I'm trying to add support for converting the scale_available attribute
>  in the iio-rescale driver.
>=20
>  The code below works fine=E2=80=A6 as long as all the possible scales re=
turned
>  by the underlying IIO device driver are translated to the exact same
>  type. The problem then is that rescale_process_scale() can return many
>  different types, while rescale_read_avail() only supports returning one
>  type.
>=20
>  I don't really know what would be the way forward. Should the
>  .read_avail callback support returning multiple types? Should
>  rescale_process_scale() have an option to force all the types to be
>  converted to a specific one?

Ah.  I don't have a particularly strong view either way.  Didn't have
the complexities of the rescale driver in mind when we read_avail() was
added (pesky hindsight ;)

If you do go with read_avail() being able to return types then a reasonably
clean way to do it might be to add a new
IIO_AVAIL_LIST_WITH_TYPE=20
and have *vals be a 3xN array with the type as the final integer.
That should only impact the core code in a few places and means no changes
to existing drivers.

Jonathan


>=20
>  Thoughts welcome.
>=20
>  Cheers,
>  -Paul
>=20
>=20
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 6949d2151025..8b00ff3de733 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -232,6 +232,19 @@ static int rescale_read_avail(struct iio_dev *indio_=
dev,
>  		*type =3D IIO_VAL_INT;
>  		return iio_read_avail_channel_raw(rescale->source,
>  						  vals, length);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (rescale->chan_processed) {
> +			return iio_read_avail_channel_attribute(rescale->source,
> +								vals, type,
> +								length,
> +								IIO_CHAN_INFO_SCALE);
> +		} else if (rescale->scale_len) {
> +			*type =3D rescale->scale_type;
> +			*length =3D rescale->scale_len;
> +			*vals =3D rescale->scale_data;
> +			return IIO_AVAIL_LIST;
> +		}
> +		fallthrough;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -266,11 +279,63 @@ static ssize_t rescale_write_ext_info(struct iio_de=
v *indio_dev,
>  					  buf, len);
>  }
> =20
> +static int rescale_init_scale_avail(struct device *dev, struct rescale *=
rescale)
> +{
> +	int ret, type, length, *data;
> +	const int *scale_raw;
> +	unsigned int i;
> +
> +	ret =3D iio_read_avail_channel_attribute(rescale->source, &scale_raw,
> +					       &type, &length,
> +					       IIO_CHAN_INFO_SCALE);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* TODO: Support IIO_AVAIL_RANGE */
> +	if (ret !=3D IIO_AVAIL_LIST)
> +		return -ENOTSUPP;
> +
> +	length <<=3D type =3D=3D IIO_VAL_INT;
> +
> +	data =3D devm_kzalloc(dev, sizeof(*data) * length, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	if (type =3D=3D IIO_VAL_INT) {
> +		/* Convert from integer to fractional form to ease processing */
> +		for (i =3D 0; i < length / 2; i++) {
> +			data[i * 2] =3D scale_raw[i];
> +			data[i * 2 + 1] =3D 1;
> +		}
> +
> +		type =3D IIO_VAL_FRACTIONAL;
> +	} else {
> +		/* Copy raw scale info into our own buffer */
> +		memcpy(data, scale_raw, sizeof(*scale_raw) * length);
> +	}
> +
> +	for (i =3D 0; i < length; i +=3D 2) {
> +		ret =3D rescale_process_scale(rescale, type,
> +					    &data[i], &data[i + 1]);
> +		if (ret < 0)
> +			return ret;
> +
> +		type =3D ret;
> +	}
> +
> +	rescale->scale_type =3D type;
> +	rescale->scale_len =3D length;
> +	rescale->scale_data =3D data;
> +
> +	return 0;
> +}
> +
>  static int rescale_configure_channel(struct device *dev,
>  				     struct rescale *rescale)
>  {
>  	struct iio_chan_spec *chan =3D &rescale->chan;
>  	struct iio_chan_spec const *schan =3D rescale->source->channel;
> +	int ret;
> =20
>  	chan->indexed =3D 1;
>  	chan->output =3D schan->output;
> @@ -303,6 +368,16 @@ static int rescale_configure_channel(struct device *=
dev,
>  	    !rescale->chan_processed)
>  		chan->info_mask_separate_available |=3D BIT(IIO_CHAN_INFO_RAW);
> =20
> +	if (iio_channel_has_available(schan, IIO_CHAN_INFO_SCALE)) {
> +		chan->info_mask_separate_available |=3D BIT(IIO_CHAN_INFO_SCALE);
> +
> +		if (!rescale->chan_processed) {
> +			ret =3D rescale_init_scale_avail(dev, rescale);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
> =20
> diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/resc=
ale.h
> index 6eecb435488f..8618955695df 100644
> --- a/include/linux/iio/afe/rescale.h
> +++ b/include/linux/iio/afe/rescale.h
> @@ -26,6 +26,8 @@ struct rescale {
>  	s32 numerator;
>  	s32 denominator;
>  	s32 offset;
> +	int scale_type, scale_len;
> +	int *scale_data;
>  };
> =20
>  int rescale_process_scale(struct rescale *rescale, int scale_type,


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDD06B5C9A
	for <lists+linux-iio@lfdr.de>; Sat, 11 Mar 2023 15:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCKOG6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Mar 2023 09:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCKOG4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2023 09:06:56 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87AA12D4AE
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 06:06:50 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id w23so8813032qtn.6
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 06:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678543610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jr4lYUE4LbhKnqlf9KsV9sgPswlPNrF5JvpcjFIiws=;
        b=efew17kBKesrHCtgPKacE9tv9x5k9D6/aVivtmVfC33CxWRbighjnL4ScqzyTiREvH
         B5OfLtmgmIMhpaMiBUkTSSZWSuY5v9NSYVNStNRzb+/fXrwYMaHcOdbmy60EkJulaI+U
         hLSAm9AChR9v/FxmKTczURztQl21LhyAQ9SpiJfEyN5Kay2GhlyYWTVw8/onpeSGZ6V2
         DMVyPIYduyWwuayiVVMBo+ow6Y/2OF2YA4/ZfcL+zPTNIiSrI+DYLFP1EWTE5uUcCBTM
         9705XMcbloVI7uIfAb8dOdTw0ivy3oSnbgqXJyZyiBarklCN03im771s18fd9lbthMXq
         uL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678543610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jr4lYUE4LbhKnqlf9KsV9sgPswlPNrF5JvpcjFIiws=;
        b=oY4rLNPEmIOzLZREjdmRW7mPYGtAtqtLtJVKeazzxIq4s55KJynIGJd8wrYHsPxF9M
         37B8hP3HxwPB3Jmbhhw4G/VUcvnshGdl5i7za/fujKVceZ5kyRjIPD8y2TfqAKt7u7mo
         7GUNBRxGg5MflWvVvscQXypSS5i1Icn9NPpp07t6JZQgT+zL3MVtDY2rIRqaTTrjdhQp
         EKp2duW7+Dpb/y626JE1l3xHcYNpd9cZTBgb+CGq3gIEiovjCe53P17Z6uZVLYlBGpOG
         w5FsCbF+P897o1KJHdIik7en1ZsIz8niXPqRxSVcvpNxWfFLATgflMDbyox7ilX4Nous
         xffw==
X-Gm-Message-State: AO0yUKWuPIDTTgHbuAx8D1NUxKP/W4r1Vs82WmE7b4QBKYlOZRPx6nOa
        nOG5V/9JeeI5y/2oRbIzlf5J6g==
X-Google-Smtp-Source: AK7set/UIRTG09WzBMk7wO+Lb/OIZ7rFPpLWper7l1UdVQLZnr7HkB4ITdvRNJIXWNz8gLzEII479g==
X-Received: by 2002:ac8:5dce:0:b0:3bf:e2ff:4c35 with SMTP id e14-20020ac85dce000000b003bfe2ff4c35mr20068022qtx.1.1678543609806;
        Sat, 11 Mar 2023 06:06:49 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 140-20020a370792000000b0073b69922cfesm1824928qkh.85.2023.03.11.06.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 06:06:49 -0800 (PST)
Date:   Sat, 11 Mar 2023 08:57:02 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: dac: cio-dac: Migrate to the regmap API
Message-ID: <ZAyIrrLrhmMJqq2w@fedora>
References: <20230311134012.70822-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7eaGiRj104sy96DY"
Content-Disposition: inline
In-Reply-To: <20230311134012.70822-1-william.gray@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--7eaGiRj104sy96DY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 11, 2023 at 08:40:12AM -0500, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

[...]

> @@ -117,8 +148,12 @@ static int cio_dac_probe(struct device *dev, unsigne=
d int id)
>  	indio_dev->name =3D dev_name(dev);
> =20
>  	/* initialize DAC outputs to 0V */
> -	for (i =3D 0; i < CIO_DAC_NUM_CHAN; i++)
> -		iowrite16(0, priv->base + i);
> +	for (i =3D 0; i < CIO_DAC_NUM_CHAN; i++) {
> +		offset =3D i * CIO_DAC_CHANNEL_STRIDE;
> +		err =3D regmap_write(priv->map, CIO_DAC_BASE + offset, 0);
> +		if (err)
> +			return err;
> +	}
> =20
>  	return devm_iio_device_register(dev, indio_dev);
>  }

As soon as I sent this I realized this last hunk is no longer necessary
because the chan_out_states array is gone so we don't need to match its
initialized state. I'll remove this block as superfluous and submit a v2
patch shortly.

William Breathitt Gray

--7eaGiRj104sy96DY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZAyIrgAKCRC1SFbKvhIj
K1z2AQCXC7YVVHrA7LJgDJsARq//xniX0yAewpIY+ix0wlp33QD9He4DCxaHI52t
Q4te1JECKhcAK2HyQaQcA7JQMK/j+A8=
=btlL
-----END PGP SIGNATURE-----

--7eaGiRj104sy96DY--

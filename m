Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C635F2C09
	for <lists+linux-iio@lfdr.de>; Mon,  3 Oct 2022 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiJCIiV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Oct 2022 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiJCIh6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2022 04:37:58 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD3450187;
        Mon,  3 Oct 2022 01:11:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q17so10881811lji.11;
        Mon, 03 Oct 2022 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9BUwF+XZJCR4cJYLZDpcdXvk0SAKfXGR6yS3B9zUzGY=;
        b=DGZMtTQdqPrFHrw9jAkijix7FwZQgmOF1AN40Glh9zxOZlqBMgNK+YgtQCBxDF+VB7
         fZb3zZsXVswJFoTTtt2AxCWOgK//IK9sb42PE/BGlK71o+aATJZ1seYyS3gF1DoU1NK+
         jtKY0RV6eyL70quAivpzR06I3xCDaFZhbWKh7+YE1XbArSpNTqYirJ8rfQKP3CQcqZM3
         tdeazwe3EILBZSLXnAH3+GKMZKs6jSPXS/eL5ZYPqaIcj7iOKsIeV4CflQVySItz1S2v
         5Js6tPJgeqOrWZfaHO/LnRo4h6+yWaV1Es2N7puJOlgAn9iI7vGLCr2I8vPhOQIN5Te0
         ClUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9BUwF+XZJCR4cJYLZDpcdXvk0SAKfXGR6yS3B9zUzGY=;
        b=RyMUEXn8JLWN0NHJC77BkSyB5oQPcpklMIVqjTR0S42IPal4z0JRFdXJN9eF5X3jSE
         3BAKG68Tzi13UW09GP2p/hn5ThtyPNuFymrCOPbQP75Fu9vhRmKc2G2JG9HgUfCqOBK8
         o4MFWAj7fCXJgC1MJSJxlrpnv7+HvUlp/AJM8SbSBPoy6bfVYHUz5YBWkegJVHK0bIAu
         Bn+1m6+iP+0QvYj5ejz70u7RdaLc2rE8gZKj8XTYH/JZYttnO+atHKT6Iil7WQv9lKUE
         ieIFYYgFa6xtCqDqerNjweEEObuNFj/d1GHbPLsGA5ZkOf1+j6+ar08lzMCe8+hb+Bij
         Gajg==
X-Gm-Message-State: ACrzQf2dVOQCboeb0GvJENcAZwuqvEjZhSnJuflZt/t97OUQzV9nCogq
        Ji4gIPUbZ456QSnlo1WELcM=
X-Google-Smtp-Source: AMsMyM4Dbl6Y8NoSUpoi8ffWtCGje77ttIWdGPAl7KRlKgK5gIPUiH2uu9hXHSHhwfz3jNlnyPs2rg==
X-Received: by 2002:a2e:bcc3:0:b0:26c:4c59:75ed with SMTP id z3-20020a2ebcc3000000b0026c4c5975edmr5810140ljp.505.1664784677371;
        Mon, 03 Oct 2022 01:11:17 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id u11-20020ac243cb000000b0048af9576d30sm1363878lfl.83.2022.10.03.01.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:11:16 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:11:12 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/10] iio: bmc150-accel-core: Fix unsafe buffer attributes
Message-ID: <cf8a56658fc38db8bed64f456d898f5ad5a2814f.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SwZjvnWCdhNkSrd/"
Content-Disposition: inline
In-Reply-To: <cover.1664782676.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--SwZjvnWCdhNkSrd/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The iio_triggered_buffer_setup_ext() was changed by
commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_=
attr")
to silently expect that all attributes given in buffer_attrs array are
device-attributes. This expectation was not forced by the API - and some
drivers did register attributes created by IIO_CONST_ATTR().

The added attribute "wrapping" does not copy the pointer to stored
string constant and when the sysfs file is read the kernel will access
to invalid location.

Change the IIO_CONST_ATTRs from the driver to IIO_DEVICE_ATTR in order
to prevent the invalid memory access.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_=
attr")

---

v2 =3D> v3:
Split change to own patch for simpler fix backporting.
---
 drivers/iio/accel/bmc150-accel-core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc1=
50-accel-core.c
index 57e8a8350cd1..92f8b139acce 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -925,17 +925,30 @@ static const struct iio_chan_spec_ext_info bmc150_acc=
el_ext_info[] =3D {
 	{ }
 };
=20
-static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
-static IIO_CONST_ATTR(hwfifo_watermark_max,
-		      __stringify(BMC150_ACCEL_FIFO_LENGTH));
+static ssize_t hwfifo_watermark_min_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", "1");
+}
+
+static ssize_t hwfifo_watermark_max_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", __stringify(BMC150_ACCEL_FIFO_LENGTH));
+}
+
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
 static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
 		       bmc150_accel_get_fifo_state, NULL, 0);
 static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
 		       bmc150_accel_get_fifo_watermark, NULL, 0);
=20
 static const struct attribute *bmc150_accel_fifo_attributes[] =3D {
-	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
 	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
 	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
 	NULL,
--=20
2.37.3


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--SwZjvnWCdhNkSrd/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM6mSAACgkQeFA3/03a
ocU7XQgAxXxbcMUQz/KZ56VfD53iTSWCJWcdPmSjsSdROefz1HOnIqcoN1EyritR
dyVQKWz2jNGNQG2/UHXM873X+BBGWmlZERb/qhLeBaA1SplUp5qUuk343WVz5h9b
/5nN1ZgNJDkx3JkuPHhFeMv7v4HF4WoUPk/spPKXpDVlaTHSUgrFQFOdSNYiDYqf
50I3CxrV28nO03f0AHAHcwNVqbkQMlvXKgFgfIJco9AVKJYFZzCwVGRlmsdMTBRb
Kq8yNxtfsru5nzWoaIHmhK1eSKQdXeMXJZyQuXZ7Wqgk2B9EiPyhHnbG5Yj95GG1
uE12Bz9cf+BQirq+M67gpz/XQwO+jw==
=VBFN
-----END PGP SIGNATURE-----

--SwZjvnWCdhNkSrd/--

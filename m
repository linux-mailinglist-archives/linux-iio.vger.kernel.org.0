Return-Path: <linux-iio+bounces-17221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CA9A6D4BF
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 08:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F95A18828A6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 07:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5672505D9;
	Mon, 24 Mar 2025 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw8d9A3G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36452500C9;
	Mon, 24 Mar 2025 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800419; cv=none; b=KTiBNExw3zZF+H8S51sGt/4nSnYaW4V3Yo6VRtzzuRIkn2GTZmg/HxPQaasqpL1WUAGGTr9O1jEkNQfvhqMeB/VEyOsaWZcVxZSsVWyzKC66J0xw+TK9b6Pd/meDNHqzzflpIghjveP8ehfLzPY6ua5z7PhcE4KNy1Odr3WM/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800419; c=relaxed/simple;
	bh=NSMSptKDxxA+mg30jX+nwXZbs8BZotVym0oijYtttek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVNVhXCSRBB/71SgIJ8TyOQGA3iVdMs/HeMux+BoUdWjGYy23HmRA1US1KM8aPa5HcvzxE5VHwYUe7ibcelgeY9XYdlLSYlf0rwRqW4pN1hx2/5aAJI47T8b7lGLNLJRedfs5siq+mZvLlGOWnuYdDHod6bk9COWkIBxHn4FzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw8d9A3G; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-307325f2436so41157841fa.0;
        Mon, 24 Mar 2025 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742800416; x=1743405216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgmO3spMSV3ya0XSwKi8qyhViZcHQWh3KY5h+If7iMY=;
        b=hw8d9A3Gcr926gg4o2QvnJgFniuqgpqke/PW0ttU3C+dnFj4LVNlKKauKREZ5OBucV
         02iB4VZk5Sy6cxntLHf6GPBNUTZ6nrcAMGlID937ISLbBhhQU8XziXUT6K7+jZ4b3l3c
         fEf9cXyOJbfdPjdd/Ba3FDMQKmEG9GWKJSUI5UzE8M1MCbVdOmjnk919h3D5s8/m6Es0
         b6KknmtqOemKIG6VcUCUbjfy5vTHTgUUeMIN4DS7wHfJknQmdf/L2JsGAXiMe3CPOTiq
         hvtqCb332CwVwLtj3wX7Ddg35+qnLPCsk3CS+JQTu0oC7z3uOF7qCxhIV0sYH1NVMPuT
         /JAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800416; x=1743405216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgmO3spMSV3ya0XSwKi8qyhViZcHQWh3KY5h+If7iMY=;
        b=VYLwy1lNO5y7GvzWkCbRgPFJ63pA8Jp4xFZ7W21v4T1bn3bLy5gIE94CB8UN+N+wUk
         iZ/7ou6/R6Sj5GHPJal2RL1y6KvtUostc0TDU4x94jCQGytqOLz93sboWBoA5Kms+G5Y
         RDSgKnkeyvc3uB2K1GN4rYGzoYXyxb7s6H7u9ujMVbvdyAsIDELiMJQuLmohdlkyNWlP
         RcCFmcMhDntX3DyXjqMOzofdS06+ynFlcV3IIlrFRF8mkMQB1Vd9dLuvt8uZXQObOJSj
         nSn7oEIyrG8GjOuDVFrYgr0AeF71uY9ddNm/zUIStMIAN7WsJQq6HP00i3sRhcj3poFr
         NI3A==
X-Forwarded-Encrypted: i=1; AJvYcCVkS2nECM6Zt+qBtHfqy4Y50bs6WOTfzlv6ebDaWj6/yejyg98k+8Ex/au/FXSRBxGvZbHwCZCngLk=@vger.kernel.org, AJvYcCXYOwkZCpsyuMM9rjoGoE2TVlJFAJ/qir7mzky6MZxtV6PEw1aWtg0Dc+durneN2c5Ik7I1zyKe94ldbAzl@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIrc/d2w4mvtxTZ58JeOa2S0qBVJnLHzo+QIHbTrxGljXkO1O
	ms5BPopbLz62TkpQy0h6iyTmCJXxzsn8jdq2e6DjQvrjc+c6wfcaq9Taog==
X-Gm-Gg: ASbGnctmAEKLweVBXTbf3gjFU04JSHmJGT5ZKb2MkJXMHCG74QJuf28YJYV0fVUW3NY
	FeNBBGUJiH6vJB4c4KeC+crysJxnHUVYaegM6apvpzvvaqwHtkejEHfUeRpi+r+1JvMeOGqkbH7
	e+VEjfKvx+D79C1u3bGstT9gbO5u5DBgVUWKec5LD0Fb0/RbmvLXfiZAAFcNIpCsjF7HszyE1DX
	xrkB9bX3hIn8FJ701USUdBFgdSkLemc1qANSCbRHjJJpZ96cpRBeneP+t5qZKZ27qitOPbhBSDq
	k4VjYsm6jWIVbBzNpYn5oVOWbHFsXpF5xtPxABGU26obxYOppHs=
X-Google-Smtp-Source: AGHT+IHvmMZhQ7UINc12GkdV/NNFv5twVruKqPihFFYmoT9ixDrjCc0MP+dwSTZVKrnR+Hoq28l74Q==
X-Received: by 2002:a2e:bc1d:0:b0:30c:2ff9:913f with SMTP id 38308e7fff4ca-30d7e202fcemr42821831fa.2.1742800415667;
        Mon, 24 Mar 2025 00:13:35 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d913196sm12558171fa.109.2025.03.24.00.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:13:33 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:13:28 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v10 5/8] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <e367a803c0d625e60c9fca16c55a25eee06b5a89.1742560649.git.mazziesaccount@gmail.com>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sLfxLgpI+RSOHiBu"
Content-Disposition: inline
In-Reply-To: <cover.1742560649.git.mazziesaccount@gmail.com>


--sLfxLgpI+RSOHiBu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new devm_iio_adc_device_alloc_chaninfo_se() -helper is intended to
help drivers avoid open-coding the for_each_node -loop for getting the
channel IDs. The helper provides standard way to detect the ADC channel
nodes (by the node name), and a standard way to convert the "reg"
-properties to channel identification numbers, used in the struct
iio_chan_spec. Furthermore, the helper can optionally check the found
channel IDs are smaller than given maximum. This is useful for callers
which later use the IDs for example for indexing a channel data array.

The original driver treated all found child nodes as channel nodes. The
new helper requires channel nodes to be named channel[@N]. This should
help avoid problems with devices which may contain also other but ADC
child nodes. Quick grep from arch/* with the sun20i-gpadc's compatible
string didn't reveal any in-tree .dts with channel nodes named
otherwise. Also, same grep shows all the in-tree .dts seem to have
channel IDs between 0..num of channels.

Use the new helper.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
NOTE: This change now drops a print "no channel children" which used to
be printed if no channel nodes were found. It also changes the return
value from -ENODEV to -ENOENT.

Revision history:
v8 =3D>
 - No changes
v7 =3D> v8:
 - drop explicit "no channels check". It is now done inside the
   devm_iio_adc_device_alloc_chaninfo_se().
v6 =3D> v7:
 - Fix function name in the commit message
v5 =3D> v6:
 - Commit message typofix
v4 =3D> v5:
 - Drop the diff-channel stuff from the commit message
v3 =3D> v4:
 - Adapt to 'drop diff-channel support' changes to ADC-helpers
 - select ADC helpers in the Kconfig
v2 =3D> v3:
 - New patch

I picked the sun20i-gpadc in this series because it has a straightforward
approach for populating the struct iio_chan_spec. Everything else except
the .channel can use 'template'-data.

This makes the sun20i-gpadc well suited to be an example user of this new
helper. I hope this patch helps to evaluate whether these helpers are worth
the hassle.

The change is compile tested only!! Testing before applying is highly
appreciated (as always!). Also, even though I tried to audit the dts
files for the reg-properties in the channel nodes, use of references
didn't make it easy. I can't guarantee I didn't miss anything.
---
 drivers/iio/adc/Kconfig            |  1 +
 drivers/iio/adc/sun20i-gpadc-iio.c | 39 +++++++++++-------------------
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e4933de0c366..0993008a1586 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1357,6 +1357,7 @@ config SUN4I_GPADC
 config SUN20I_GPADC
 	tristate "Allwinner D1/T113s/T507/R329 and similar GPADCs driver"
 	depends on ARCH_SUNXI || COMPILE_TEST
+	select IIO_ADC_HELPER
 	help
 	  Say yes here to build support for Allwinner (D1, T113, T507 and R329)
 	  SoCs GPADC. This ADC provides up to 16 channels.
diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gp=
adc-iio.c
index 136b8d9c294f..2428ea69d676 100644
--- a/drivers/iio/adc/sun20i-gpadc-iio.c
+++ b/drivers/iio/adc/sun20i-gpadc-iio.c
@@ -15,6 +15,7 @@
 #include <linux/property.h>
 #include <linux/reset.h>
=20
+#include <linux/iio/adc-helpers.h>
 #include <linux/iio/iio.h>
=20
 #define SUN20I_GPADC_DRIVER_NAME	"sun20i-gpadc"
@@ -149,36 +150,23 @@ static void sun20i_gpadc_reset_assert(void *data)
 	reset_control_assert(rst);
 }
=20
+static const struct iio_chan_spec sun20i_gpadc_chan_template =3D {
+	.type =3D IIO_VOLTAGE,
+	.indexed =3D 1,
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
+};
+
 static int sun20i_gpadc_alloc_channels(struct iio_dev *indio_dev,
 				       struct device *dev)
 {
-	unsigned int channel;
-	int num_channels, i, ret;
+	int num_channels;
 	struct iio_chan_spec *channels;
=20
-	num_channels =3D device_get_child_node_count(dev);
-	if (num_channels =3D=3D 0)
-		return dev_err_probe(dev, -ENODEV, "no channel children\n");
-
-	channels =3D devm_kcalloc(dev, num_channels, sizeof(*channels),
-				GFP_KERNEL);
-	if (!channels)
-		return -ENOMEM;
-
-	i =3D 0;
-	device_for_each_child_node_scoped(dev, node) {
-		ret =3D fwnode_property_read_u32(node, "reg", &channel);
-		if (ret)
-			return dev_err_probe(dev, ret, "invalid channel number\n");
-
-		channels[i].type =3D IIO_VOLTAGE;
-		channels[i].indexed =3D 1;
-		channels[i].channel =3D channel;
-		channels[i].info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
-		channels[i].info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE);
-
-		i++;
-	}
+	num_channels =3D devm_iio_adc_device_alloc_chaninfo_se(dev,
+				&sun20i_gpadc_chan_template, -1, &channels);
+	if (num_channels < 0)
+		return num_channels;
=20
 	indio_dev->channels =3D channels;
 	indio_dev->num_channels =3D num_channels;
@@ -271,3 +259,4 @@ module_platform_driver(sun20i_gpadc_driver);
 MODULE_DESCRIPTION("ADC driver for sunxi platforms");
 MODULE_AUTHOR("Maksim Kiselev <bigunclemax@gmail.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DRIVER");
--=20
2.49.0


--sLfxLgpI+RSOHiBu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhBhgACgkQeFA3/03a
ocWpAQgAtegzSV9b1MqKbin6TsL4sVZQhZBySnTY3uMGX61W160CWt2mo5soZW3q
gIRhD6/UED57xk8uEGDMZBfhh82692r/hNo8n7xviFaLGyNsjUHwrfTUU3P4piiz
oiUFe1ouZy6Wr0HDDLiH3UVA4d7nVInoRRQwjS+JHEYAgAW9uSZdEPFO8Rttu8Zz
SEJlDv0S/7tNWcOd/se0xY9q/wWNVscGP5HKoTnLyuhM9o2FGMyj3v7pE726ZTf3
18s85OQuuADurNKaLCC27j7SngXG09vpxygdfYde4/kBUluLoywjGtnCmYWU2ROh
m+SKv/ht5dpPDhR2XQbpUEu/wT3hTQ==
=/T4m
-----END PGP SIGNATURE-----

--sLfxLgpI+RSOHiBu--


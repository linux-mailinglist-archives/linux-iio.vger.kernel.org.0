Return-Path: <linux-iio+bounces-16264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073D7A4BED2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A678616434B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7D01FCCEC;
	Mon,  3 Mar 2025 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeQBsAp7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A821FCCE1;
	Mon,  3 Mar 2025 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001593; cv=none; b=lrCJmCBuuI+GaUOjgmXeHsTB8BKVTT24ZlRvtZeWocjCvuWubgJCH02jLUWQJPtRQhqCGPDkemWCnNHb5aTW8U3jBtBGm9V04LaVFk0fQ9TnBJhsjbuxQHF5Hl7QJJrhPCP66mmkRvC6ZTImr/3KvZT65k9V0I53uZCvU6+9sgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001593; c=relaxed/simple;
	bh=qY4K5AlxxWkcTPDlFeU8FDxqWCpkT0NIf9/vZt+9LAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSKFBJuK34UUf/HEJfqebATL6UJgy9gk/r1wT/PQ1jZYlDAo39BwilHlcJ6h81MMqfpxuL9siyRJGH5VTfZz1qyptAdo3rVIaQr9g/0MV5homocOiiocXnRnZpCL6K5lzMa6CtV17V/s629JmzUT34a5aLoKu4xTYD0UFbM8mKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeQBsAp7; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so45986501fa.1;
        Mon, 03 Mar 2025 03:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741001589; x=1741606389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jr7uWyzHUY99eCAGXzsJFETrGHISY9L/T3cghzdv3dw=;
        b=KeQBsAp7sx/0gSio3CEWklIVD60pWFWLMSJJivb82nz7aQE/5fRhkbUcNkUJHnnSCT
         XbThKtVWzY9Ha4VSV5eWd01ynP3zsqKunPcuX3YDqy6Y4mwmuNelcdPROPuIholQlPy2
         JOSLMpDsXmt/Q60eq7DkywlPyxSqaSMXfJRilTfLQz1z9Mj2WH2FTDMVarzHyiDLPH4o
         1L+yiQtcX10MSyLbn6JPMPXzlC88TUaQzhWxjUoq+5DeLPlAIwJMyaqzPERRNptQ7jyR
         qzcepHZu8CKXCBhkrA7MHwprKV/UgGBRIK/Qu82CU4AcJNlpo88u263M4w0qz40iDHYm
         TI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001589; x=1741606389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr7uWyzHUY99eCAGXzsJFETrGHISY9L/T3cghzdv3dw=;
        b=fRBdZyagx5IdyiRYLyg3mBpkVrxpJ5v5+BH2kz0RfdEwymaagk4rxV7KlqZvAmKs6f
         Yoj56MJu3TgQjm0GVDE7AEuXEt42CynjjUziUK7i5BZ9gqoKvz8lpYc5cf5Dh3qCj5oh
         c3/RKPwdxzaiPQn+NGnC2qRJLYzhyfEb7rQ8KriRJxbCxx/sF0yFoLv0UAeCf5zdXNe5
         i85u/Kt1oDABJa4huP5ACZhY3kXp2ohSePHgTgi3APuoQdTYC1zYGxIvATovrsshBJGn
         lT+QF1ZEWB8Yg/BE+F0IFtCsF454MmZ7ObGByOA00aES7iM1DFMuJElP4FTswybQnl45
         PWzw==
X-Forwarded-Encrypted: i=1; AJvYcCWOKbDPY+WOOHtz74lztUD9+rZbDbjGCExg46meV7o+6I1KV5UC7K0cKH4HEaA5+PlqPKHX1kxqUrWMW034@vger.kernel.org, AJvYcCXqKZF3bduNJgiXmuhzy4PSwbTtqL4yoeTObvxDLFVAg23VVvpnwnmUe69QZU4GczhAMSyVAFTNHaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LkDxIMiLX7fIpS4FSlWiJF5AzWh10U7+vRAhf+FJCBZ2muyv
	wB4Vi0kMIR5VMrVfXH5eiS2nkfbDtwrac5OAJnqDFBQGZR4ifZ1r
X-Gm-Gg: ASbGncv3N+2BRp+D9gfKB23Ux8AgAOgKAbqy6E4qZ+uiFKEoPRhfPapS6w4uNUMYVWp
	DmAj/zT0Ie1/Y0OJCOFOChigJ2RsGkM4fFipDYlOBV02KAfYnxr/fnpYzCxyuOdOc5vXp5IuVXj
	vjj/AElQsK0V9CBLDt6FdEvU60KmPqdKLedAETusDpOGH11sNs+FKb4K7GA+uCMVLp1a+4xf2jS
	8FJDiOQRtOnzUtqoHb8JgVYmbe50TDgcypP1NpVFk6bQ9mV7san4ATQXCepX19o7CJ9j3TY2IWO
	bBNC8By3QbbJD1Gb4bn83OHGIT4h7RFr24spVjIGOy0Wxpr3TmJLNMrjpvHZ7XTVbWzrmN25Hgx
	bIB2ohmh6oOM=
X-Google-Smtp-Source: AGHT+IGzOR5aUmDt+a/MXoTy+5OLlJ65L1UVO+lQK86VsDtTaAuu0JJFF79k+4B/QbjhjBDZ83bKrA==
X-Received: by 2002:a05:6512:398e:b0:545:3031:40aa with SMTP id 2adb3069b0e04-5494c129d52mr4959258e87.9.1741001588885;
        Mon, 03 Mar 2025 03:33:08 -0800 (PST)
Received: from mva-rohm (mobile-access-2e8451-125.dhcp.inet.fi. [46.132.81.125])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494ab017d0sm1112555e87.84.2025.03.03.03.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:33:07 -0800 (PST)
Date: Mon, 3 Mar 2025 13:33:02 +0200
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
Subject: [PATCH v5 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <aabd8836dbe54ef54730d1cd112edb52a57cd353.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H68W2IZGPpj37wy+"
Content-Disposition: inline
In-Reply-To: <cover.1740993491.git.mazziesaccount@gmail.com>


--H68W2IZGPpj37wy+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
drivers avoid open-coding the for_each_node -loop for getting the
channel IDs. The helper provides standard way to detect the ADC channel
nodes (by the node name), and a standard way to convert the "reg"
-propereties to channel identification numbers, used in the struct
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

---
Revision history:
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
 drivers/iio/adc/sun20i-gpadc-iio.c | 38 ++++++++++++------------------
 2 files changed, 16 insertions(+), 23 deletions(-)

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
index 136b8d9c294f..bf1db2a3de9b 100644
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
@@ -149,37 +150,27 @@ static void sun20i_gpadc_reset_assert(void *data)
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
+	num_channels =3D devm_iio_adc_device_alloc_chaninfo_se(dev,
+				&sun20i_gpadc_chan_template, -1, &channels);
+	if (num_channels < 0)
+		return num_channels;
+
 	if (num_channels =3D=3D 0)
 		return dev_err_probe(dev, -ENODEV, "no channel children\n");
=20
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
-
 	indio_dev->channels =3D channels;
 	indio_dev->num_channels =3D num_channels;
=20
@@ -271,3 +262,4 @@ module_platform_driver(sun20i_gpadc_driver);
 MODULE_DESCRIPTION("ADC driver for sunxi platforms");
 MODULE_AUTHOR("Maksim Kiselev <bigunclemax@gmail.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DRIVER");
--=20
2.48.1


--H68W2IZGPpj37wy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfFk24ACgkQeFA3/03a
ocW3swgAxdspJKGNebP1wZLtgdUEjveykgvwtguklkaV129G98UZsW3m94ma/8m8
qTIwg6fC53R3rsy0PgoGQA0rzgCLxLs5SyU7dJ9VBP0rtd/W1QuLjlB2lSWWQ0VZ
iHEMHTpXN0UECsPhnjdx2AkIV9OhXogF1lUE5SPWmFBwNMqTMN9kuyNmlN3oyi22
TE/xmHUroVD1hbsnX5LaMIWNC52jrANcg2/fxs6gnXbHvRnlAjxU/07S1p2YEhaF
NB0fjePrXCd1vcb7wlozyiQxfZzRqH+qtkExmCstmeb+TgLHTokJUZu0JlUmSt91
L0Chh63By3LN3Z0zGlOnGIyhf5FcwA==
=Wlf0
-----END PGP SIGNATURE-----

--H68W2IZGPpj37wy+--


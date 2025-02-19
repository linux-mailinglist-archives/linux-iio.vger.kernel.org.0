Return-Path: <linux-iio+bounces-15784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9823A3BE33
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9BC16B00B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D221E5B88;
	Wed, 19 Feb 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="carIGxqz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2724C1E5B71;
	Wed, 19 Feb 2025 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968321; cv=none; b=pvIoAj16eDDBxO7Cq7KVuLd32hk727QxON9SvNwbHR94apARVFk3r83dudAE94UYQ1po6orBYywcwr3je2bUgMz7WACiZPBDKATTQK8br76OUFNE0xJi/CbDnXhEDe4gRVtaJTeVYqsOR4Z/0adY061pCNQIGwuShNCR3m9ZU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968321; c=relaxed/simple;
	bh=U0JRwfZpNRp+812FgOW9ZHl/nMZWKI1NbdstILYPpaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoWnd7Nw2gDskOKLxHnZcHUuL+4fna8UYNM4iOBiiqGgJZMKzztDA7ibDB/qt+yZ9u1FDsJOVxImQLSKUOxBC4+aN0bSXKpqAnplpBEK1UHIAJ6crBvAdz8CmaQ154sCxgjQDFOECAvipaqZQzcH/XEW+NaidYF7QbSBtDqqARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=carIGxqz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5461b5281bcso3422299e87.3;
        Wed, 19 Feb 2025 04:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739968317; x=1740573117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/8lsdpKrVRGvDk8bdsIYhaiCtFIej4Yk5OWrIJakDc=;
        b=carIGxqzkRkRgey0H0ILDYuhc/AsFMSBHEJ+nwaKN9kGg8imcDRk16skeysNqFUTNd
         ObskyAo22W/XKs0vZtDR50tcFwZsa8WfGkETMk+eRJvHhqqEzUo2g+vIasCv0ic9fdf/
         u0BmtoE05G/42htdRf6ZbPNSFk5VkEDFEd1ixvvOVR+duSznx1DRBfRAU83jlOVBMBmH
         B+k6b/KN7Mi1Z2ivK37NZazh/7gxIBcNWVawQ5C03fpuz39PeSLCIqpxB4drR4HMzgf0
         JYGYA1iqiuqs764kqVFcdYEORn9Gt6xJFjZw0ujkAWSd2gfV/MxUh8U+3EcN8kq5h3bB
         Ot2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968317; x=1740573117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/8lsdpKrVRGvDk8bdsIYhaiCtFIej4Yk5OWrIJakDc=;
        b=RQ1/bPoU04Y5jtBFQzmwGoTWdhAsShUjoVgqeL3xLfecCT90CnrQuenAi77aMQHuCi
         bmYO6gBV4v2TIMXaumlwBUCmGf7WrwdECsUJ53XS8vx8furg8PxwdUuW7MVP2I9ipBjt
         A8bAFJB6da/DgfC/XIW7WOnjmKv0/Hc6xy4xLxnMcSH4DUoTvQSisNCrHxqF9rk5vZP7
         L5uFvgzKhYCfouMWiEM3NkkMfvAEzDwmbljIuyADrW6+QfDzCeShmVKqKlVFSOMHzYLq
         UR33g60K88njomT7KxNgVfPzY9eC2YC473EptpN6mCm9a41Xf7/OAtr/bTSSmcziRB7i
         z9jA==
X-Forwarded-Encrypted: i=1; AJvYcCUO+5FjQd4PnVWcnnHAxse24tkII8ZrmYc0iYAQJF3MVP5VLrenKaF8of896AcgidH+IF+nKfGzi86x@vger.kernel.org, AJvYcCWveyMinYaT+h5i9VzgDUAN2nnIcXV6rO/VV/AHlAfHhglsm+7IxImFTwIN/sU1y44VRujptKBqVprdFlhLlqPv8Ik=@vger.kernel.org, AJvYcCX2TOX5+pw3Q+KHc7KK4Iubm7Ei2gkROePHpZp5poAtYJNN/cxxJG4a4JmtMXWSWKrmYsjIZK7vCauL1pNW@vger.kernel.org, AJvYcCXVaftHwN5bJ123qIad45YWSOHw+PbLC3gZGDZmKEw80bmJ8cqu8HqXb9dhLcin/dlFyQ7D2/RjZc+/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Po1IUze8MVDN1imFT4dTNddUcaCwnWW1HU3jUQ9Say152xNL
	VREckkBMAjw8946/eNVb356sv6YLqxbT8Lrj1rE3MWEq9arCMemZ
X-Gm-Gg: ASbGnct9fWLpnw9np+ARnbbPyEr+zp9Y7AQvvODgZ5HW9jURNmSuzI+7ww8cKkl47wI
	sHiax1v4k/dyfczqhZROys9VkCVlaqt3qkSIjEqQE1wsazPZk27HokCGwLloMJl6f8n0c7h0kYk
	IvxaPfVrnsxyM3+1H4qbjw++rGa6b2F+3s5QnEcRCcFDchBx0IF5QV4RVZsbGXmtB3cfrxEOnTK
	m208SNsSxBoGoYcZ1+y0loAFVcZlxHXdPx/8PSUG3SjpKjg0e1xwQd/vt4xmrJeFRYATQTzsdml
	Q38I5d7SGPIvxL8d3poSkQ==
X-Google-Smtp-Source: AGHT+IHxBzOtMjJ6R20Hyns4SI3S/h1XqzVvWjCS9fdPX3gfnk60+xs7fGA4Wr7UNOkuWHPHq9EJQw==
X-Received: by 2002:a05:6512:1286:b0:545:2950:5360 with SMTP id 2adb3069b0e04-5452fe570a5mr6750403e87.22.1739968316988;
        Wed, 19 Feb 2025 04:31:56 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461db6474bsm1137730e87.58.2025.02.19.04.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:31:56 -0800 (PST)
Date: Wed, 19 Feb 2025 14:31:51 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v3 7/9] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <21b9af362b64a1d9c2a13cc46242dd6955996c46.1739967040.git.mazziesaccount@gmail.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s1x8TMYhsB4jne8Z"
Content-Disposition: inline
In-Reply-To: <cover.1739967040.git.mazziesaccount@gmail.com>


--s1x8TMYhsB4jne8Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
drivers avoid open-coding the for_each_node -loop for getting the
channel IDs. The helper provides standard way to detect the ADC channel
nodes (by the node name), and a standard way to convert the "reg",
"diff-channels", "single-channel" and the "common-mode-channel" to
channel identification numbers used in the struct iio_chan_spec.
Furthermore, the helper checks the ID is in range of 0 ... num-channels.

The original driver treated all found child nodes as channel nodes. The
new helper requires channel nodes to be named channel[@N]. This should
help avoid problems with devices which may contain also other but ADC
child nodes. Quick grep from arch/* with the sun20i-gpadc's compatible
string didn't reveal any in-tree .dts with channel nodes named
othervice. Also, same grep shows all the in-tree .dts seem to have
channel IDs between 0..num of channels.

Use the new helper.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
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
 drivers/iio/adc/sun20i-gpadc-iio.c | 42 ++++++++++++++----------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gp=
adc-iio.c
index 136b8d9c294f..36d48d95f029 100644
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
@@ -149,37 +150,32 @@ static void sun20i_gpadc_reset_assert(void *data)
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
+static const struct iio_adc_props sun20i_gpadc_chan_props =3D {
+	.required =3D IIO_ADC_CHAN_PROP_TYPE_REG,
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
+	num_channels =3D devm_iio_adc_device_alloc_chaninfo(dev,
+					&sun20i_gpadc_chan_template, &channels,
+					&sun20i_gpadc_chan_props);
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
--=20
2.48.1


--s1x8TMYhsB4jne8Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme1zzcACgkQeFA3/03a
ocVCEQf/apaKkLHlAvNzeV+JKHo6yZDGv6rn7zx2MXDtaPiound3ykKHcgPY498P
38ikuU9ndRbuvC8VnJgdM3Zl1/A2LwH4Oucpkf8YfLiOg0lhowQdvdENcvbDGGX2
55HgTmhlDc/ZalxeQw+BskM+IMTdXdc038K9MiwtpghKgqRCpSc42+qlLlf+PKOV
OmHPs56Ieg7eljc1b/BtnXQLsoEIV9c4G4TmD0RZ2HweNAcoIKgJDGgfj9HsISUf
0A0Py6UOsR5makm7tLhBfAzDd+qhixmrtt2tZZYSIF7h9mnMd7S4+CtJMWdAj4fG
PQSvCuR17XsboEperUGS7DRuGu4tuA==
=t+wj
-----END PGP SIGNATURE-----

--s1x8TMYhsB4jne8Z--


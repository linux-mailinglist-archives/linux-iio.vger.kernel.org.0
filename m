Return-Path: <linux-iio+bounces-16026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDEBA42B68
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 19:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AAF188393D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589AC265CA8;
	Mon, 24 Feb 2025 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKPR8Xn4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69643264FBA;
	Mon, 24 Feb 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421990; cv=none; b=AvEHiD6Os6AoYQcEvrzF1xZXCxYVEH5lpN+t6dYqgoFYVJcNgjEdF0r7tXedRg2w1yzOTgUDQtCVKTN7pvgyx3i2k8qAxvwVAXHOCgbh9OS4Jc/eV2kOd+oI7XBtiPY4fSSIt5/yiu1FFSZA4Gtmata1DNhUUTGcD+HEpwQu5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421990; c=relaxed/simple;
	bh=DxQZnEWKOJxTKJJIiD9R1K0zD2Ow0veeUtytjVV/gKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjDWDRC1bfWUmRlpXP7ly2GpQyEoyPFzyDdZQgGaUlkiHudqnfDKM6fjJ39d7XKXVHQjYvvJ1+epZBaAH087wc5vHzk0Lsowa1fmIo5gHL3B34TQo16N/ztXcSYIl4i7m7THSPQl+6JL4ROY22blHTcRLwifZOsSwq66/9s+qg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKPR8Xn4; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5452c2805bcso5236146e87.2;
        Mon, 24 Feb 2025 10:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740421986; x=1741026786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSOud79Vzi0uiSwrFzUVnpNiszCNIWd+xmMcmCt0CGY=;
        b=RKPR8Xn4GjtOiZrIEJHbKNWUzcnJOVlwK6IS2X1tYyFJBq3WriNfjs4iz3j5Xr4sZc
         lA9/6mC2s6+GZMVGVocRwNETXUQ+VvuKUyepJI4Xo0vkE76hIoJlH8qpQBpgVTQ0yDtb
         3df2ASkK+AHMKg8hRT6DmLcEfxxXN6WYw+tBpQzfA/qn8GB3FFYaPWe4A5gfRxjpixJH
         5DDPEfncAg6X6XC/P2rTlNQamXX0NGvpAvVA8pIg6mbOiy3pNQzO1WVjUTD608ugOoGk
         WpQzGyxL8KW9XOwGJSb+v0tg91PhdPB1CDqOloJfUIofyImI7hXev4q7JySlGKBa6dS0
         crVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740421986; x=1741026786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSOud79Vzi0uiSwrFzUVnpNiszCNIWd+xmMcmCt0CGY=;
        b=iX37VBmqENvbhKa+/IXedm+hjPJ4hWojbxni0j356m+8YFEx2tWf0i6fJxQo6qAnuz
         wh+plJvmJNH+CRh91eBzWkiUH7LKY/1mue+f1smsA8JwjHRgtpIG/cFn2n2B6pOp83i1
         s66eVTDZl//cDrx8HrGC+27iSUuAz4samaxdbMXXLHkRAIdlo6fy+lutUSygJsDb+jvL
         Ss1e6erVrnmu3MKPrh+nzAIzwt1mN3z1aUWHP2qquOTk0K48HCNcH6+qJ0ZxXB9ecZ3C
         VXG92QNIi3A+shR+LBOzqwfgmw9CQWKbnVN/JOXZJAeGFNcPrHXJ+MNQr3XGARsZVPWE
         wIWg==
X-Forwarded-Encrypted: i=1; AJvYcCUHceewn3DAImvaPJfkVtXfO8gX9Pkth2MnTUkMQChHs6cQ5xZynnqWcXppJpveejijjYpZLNZyysf96XJXJ20sNtU=@vger.kernel.org, AJvYcCVcJSupmOFqDlREPDAZdp7dwzPXYAcb6QqQhFgcdLOcPbeNLzP0NGiXW7I34zthZ5sE5p2vSuG8I2/V@vger.kernel.org, AJvYcCVtnV1nSrSr8hl0RGliz4GMgPsZPOhKUb5NCVM+FMQTcEot6yEtGdGPoZGM06/76nkegm44z45hZ+NnDSen@vger.kernel.org, AJvYcCW8b//eejsNFvc7bnnxja66seYShUk74o+IHvIV/Qqpv0R2KRKXOOvBo9x0Q1z8jFqFcq1TvINBQfsPWA==@vger.kernel.org, AJvYcCXHYm7zeOywT0z7R9wTHuTZqhPNCPq/lHEc0TIGVUT0dwIXcHcg4kBegGaYrUT8LeQttmmc6ypFnZDO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8E9c51BnqETUfz4tTSghrDRcfw8jEiouz8BmUMLwCmTqccmik
	+PrS9kCS+k/2zaY/Hi3hfZAyrR3skXCU6mktBOicswfS6Svf1dzA
X-Gm-Gg: ASbGncsgBsDLpQGyrPT+N5aHYSxBXHta2iAVI8ZQmKId7WK2kBELiDSnUnSjtQhHuPY
	XZ3JL06LO8HeFUsob5UoBVdyOkXGbh0V17/y5W3V/FM/LHR0ZpvDBJt79Jl1X5Srdex3fcGlwuX
	0NO/V7kQrjcoOWVMrjEp+Nb2aM9UpWrsVBIUSC8/UXL5jKFpkyEkTk67kGyCksNOS1OOVPYQ7Ha
	LBudPYBPoUQp1E1dfGhk838eR403+XAh8fVJVvum+30Li2B3gm9IoacinObKpZZ8aCFVgPkGUVf
	6URKWeUp/D0hiSjl7K5pwjaQc9xgTq4s
X-Google-Smtp-Source: AGHT+IEb7m6b4nDvSqYxkQoqLJkKID/UW05aywoBDG1L44MOe5fbAylNbYH/ooMs67cDj3WL7N982Q==
X-Received: by 2002:a05:6512:2814:b0:545:60b:f38c with SMTP id 2adb3069b0e04-548510ed080mr34279e87.41.1740421986219;
        Mon, 24 Feb 2025 10:33:06 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461e731f02sm2539348e87.192.2025.02.24.10.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:33:05 -0800 (PST)
Date: Mon, 24 Feb 2025 20:32:59 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v4 02/10] property: Add device_get_child_node_count_named()
Message-ID: <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7y8fnmahBQr1cajK"
Content-Disposition: inline
In-Reply-To: <cover.1740421248.git.mazziesaccount@gmail.com>


--7y8fnmahBQr1cajK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are some use-cases where child nodes with a specific name need to
be parsed. In a few cases the data from the found nodes is added to an
array which is allocated based on the number of found nodes. One example
of such use is the IIO subsystem's ADC channel nodes, where the relevant
nodes are named as channel[@N].

Add a helper for counting device's sub-nodes with certain name instead
of open-coding this in every user.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v3 =3D> v4:
 - New patch as suggested by Jonathan, see discussion in:
https://lore.kernel.org/lkml/20250223161338.5c896280@jic23-huawei/
---
 drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c1392743df9c..3f85818183cd 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -945,6 +945,34 @@ unsigned int device_get_child_node_count(const struct =
device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_child_node_count);
=20
+/**
+ * device_get_child_node_count_named - number of child nodes with given na=
me
+ *
+ * Scan device's child nodes and find all the nodes with a specific name a=
nd
+ * return the number of found nodes. Potential '@number' -ending for scann=
ed
+ * names is ignored. Eg,
+ * device_get_child_node_count(dev, "channel");
+ * would match all the nodes:
+ * channel { }, channel@0 {}, channel@0xabba {}...
+ *
+ * @dev: Device to count the child nodes for
+ *
+ * Return: the number of child nodes with a matching name for a given devi=
ce.
+ */
+unsigned int device_get_child_node_count_named(const struct device *dev,
+					       const char *name)
+{
+	struct fwnode_handle *child;
+	unsigned int count =3D 0;
+
+	device_for_each_child_node(dev, child)
+		if (fwnode_name_eq(child, "channel"))
+			count++;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(device_get_child_node_count_named);
+
 bool device_dma_supported(const struct device *dev)
 {
 	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
diff --git a/include/linux/property.h b/include/linux/property.h
index e214ecd241eb..a2770197f76b 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -209,6 +209,8 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, =
unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *=
name);
=20
 unsigned int device_get_child_node_count(const struct device *dev);
+unsigned int device_get_child_node_count_named(const struct device *dev,
+					       const char *name);
=20
 static inline int device_property_read_u8(const struct device *dev,
 					  const char *propname, u8 *val)
--=20
2.48.1


--7y8fnmahBQr1cajK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme8u1sACgkQeFA3/03a
ocXtLggAgT5j/TSPxFsS/2C4xsWLs0/6SO9w6j9Ijy5MvfzcRBrH3Oc7aaWUzbrp
PPBZZzZYFn8NKT2exitsIOYpDFgQCSbwyf/+CQvoDcTfNw8NoEQwVYLV/oA3C/RZ
hBb0Rp5giodlJeN6mtzVfLQLTws+HRlrwogLb50yRxNWROlPMTDcAm3Mew6/MxqT
ULoEVgMmOIAOWFjvOw/HvD1qZnqrmMeIMk+5xyImS0JfN8S6AA8TJecvMLoXtq5y
e7jQrOztxk58RGrz6XQOmth61X7dQbAFu7SwuqTHeA8MtW4DQkhguM7B5eTOZqXN
YLmBzoJxbFu5Hh1nAFnl00fE/COr1Q==
=b5lW
-----END PGP SIGNATURE-----

--7y8fnmahBQr1cajK--


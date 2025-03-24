Return-Path: <linux-iio+bounces-17218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B87A6D4B3
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 08:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA60516CB64
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 07:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4DC2505DA;
	Mon, 24 Mar 2025 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt8UdR+v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6F4282F0;
	Mon, 24 Mar 2025 07:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800381; cv=none; b=MFBQjx1vsvwxbsapO3uJNWtjiQO7G51ZsAw47knKoNS3A1AOXQexsSL7BcMMhFVmrgC29ZUxItp1EnA+ZfOoQ6ChHMr3rzfZLZb352yC7Ek3s/hBrtJ0yfehVop1oVv9PruO9/tGJQMlRCM1slEv+HTn8hU2aYG6vZ+HMKLaViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800381; c=relaxed/simple;
	bh=Caim2qosHb/7HoYtNNq2x8G//Sx5FkRFFkKM1X7MrRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbFAZwA6cBE/K4lSkLK5A5vPj9o+/UUtOniddE17/s/lgnHZiCwyiIFkv7uPybwMjOEDStugWa6t7him6HohMcc1aAEH9GwFk5HR6jpFosHjfqPW9iZ9W/N0avKIkNLMMX+rE4IbBGujDPn67VylgRM65WKhJEuNZOfqNMmoPHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt8UdR+v; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so4805815e87.2;
        Mon, 24 Mar 2025 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742800377; x=1743405177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb6ZekWLkVePTuMzLCdqRm3yrgquLep1rTqCU69e+sA=;
        b=Jt8UdR+v5Ti8ddca04DeIyiNTZtRqmxsd5fekeWL3tSQ/M2wVgTHN+01nt5EmKXG8H
         QI/PY2rT+ohCrK7h1fdAvdyD5lXmSLJ35AgMONWvIXWZC0EfwmcyUFaNzGXP3DGRzbE3
         0EZMCYQzjhKpKJG7Kc5Z84eg8f8HDGXbhbvoKMfiykVw4lGbM+VzMHUDHQszkPovSeGM
         zDodeVz+OCp+4GIx5cPRk2S1hkgqLKw9HCwlAHMaVjcWuDqfam41gjYQuSbYtiyEPVLh
         RAXmS4eJv8h8O3zc27EY1Tjjhc+et8FwP+qOG4CFNOCyM9xnogHe+xJriY/2aBNNKub6
         /0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800377; x=1743405177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb6ZekWLkVePTuMzLCdqRm3yrgquLep1rTqCU69e+sA=;
        b=Q5nb9R5nSA/ROzPBpatz81rzs0tbory7GugA4+BpRQnkVAS2jN1Ndwvt2n987901LR
         8cx4Rcile/8e5qjGCIIvb76oaL1ROPva72lvSpqFblLOCiKcwPo/2QNclFwbQShaDbEe
         rmqhA1Mr74uTYcQRdgPLJ6ejCvR1mfBbrsTrUeFt6ly/UM/OvDRtaRmKlYRDLOzNOnaT
         oWHVC2zyVF7XrrVGHVd/iItCnSjPFX+rNcuitSRraWdwBMd3ruJUX4LmiLtmvJozszxc
         DkG4etHgwZe39zY8MS3iP0/n4pyrc9t+1H2luSxHvhxsa/gvKNIqDaa5iLkhStZyUEai
         Z5nA==
X-Forwarded-Encrypted: i=1; AJvYcCUh98lZ6il1CNCDeD+Fo/Zpa/tl+2No8xn4vCAbD5Oa/Bhi1Ln19wvqDSJ5Zg2WF6D6aSl9E+Zd/pIk8C0I@vger.kernel.org, AJvYcCV+muB6SBUkk3RgoeQWNK4L3oJnh2PEvxA6FrY5IJVsLhsetRHsIt6PoT9MNaxUMbNHVDVf1RsDyC7V@vger.kernel.org, AJvYcCV6MG4rw+VIhLIMbNhEMH0+Rwf6xqOcGhkzZ3AbZxhmjEDVEp91zgWkHnosS1EBgP6Zwzrx8MIVSQSR@vger.kernel.org, AJvYcCWVzSulfqIAoY8GuSXMBuouTzI7Hj6vCmk3Yn8OYRbd33uYDZgulgVEz8qNczz1OqJwVoTcw3skm+v0c5VMQoPfiCo=@vger.kernel.org, AJvYcCWlm3YRO+O3A+Ij6h5PZB1EWBs1NSLI3cO4SjK7dMY+8jmNcbQ72GRmfxzq+AwYhzQdZBQmnKySvHWL6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM07p3tsoXM813kYz57DgtR9jlVxE4laEnxn00cOD3I7wjWDRw
	uQZyx02R2Uxi6hTOrEH2HzrlqjyVzR9CphP4vjOR+pOozv7fncyR
X-Gm-Gg: ASbGncvMgNs3t4a+x0X1tZWe3ghHKcNAAbxsNSza19EIQuWgFhmr0vQtbTz+HvlPABD
	aMIIrxIC07QI1HhgZZxUy5lJfmUMvKdBXYSX873dA0EitCBlf5ewFP/LPL4fNQsbLpyvvfjFf0E
	KY9AJeZ43TKYQXUumsEwuY6lhbtPVu98sMruOSkCpWY98QLZ6kGCW1Jrcr8cdAgsDihFHAtJjFc
	zqxgYC90pVIdEUfVIZA4hNzLsOF/r6rhdQT1PRqF60+mRhBOHLtaemhY+UgvDghLrsj9c/ZFIKe
	G++fgx/c/0LtF6r9vf5kSy+enaM6HcAqdgjnncgD0v6j2cDJbYY=
X-Google-Smtp-Source: AGHT+IHmmYJxZaoxJegOFs7H2qFgMQysAz3M56PHCG4I22aUs9ljmNowu7LQ3Ype2zutd04sqwhXUw==
X-Received: by 2002:a05:6512:10d4:b0:545:1082:91a1 with SMTP id 2adb3069b0e04-54ad64807e9mr3497478e87.7.1742800377109;
        Mon, 24 Mar 2025 00:12:57 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647b468sm1032949e87.59.2025.03.24.00.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:12:55 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:12:50 +0200
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
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v10 2/8] property: Add functions to iterate named child
Message-ID: <2767173b7b18e974c0bac244688214bd3863ff06.1742560649.git.mazziesaccount@gmail.com>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yXCZzpyh11Z9uerG"
Content-Disposition: inline
In-Reply-To: <cover.1742560649.git.mazziesaccount@gmail.com>


--yXCZzpyh11Z9uerG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are a few use-cases where child nodes with a specific name need to
be parsed. Code like:

fwnode_for_each_child_node()
	if (fwnode_name_eq())
		...

can be found from a various drivers/subsystems. Adding a macro for this
can simplify things a bit.

In a few cases the data from the found nodes is later added to an array,
which is allocated based on the number of found nodes. One example of
such use is the IIO subsystem's ADC channel nodes, where the relevant
nodes are named as channel[@N].

Add helpers for iterating and counting device's sub-nodes with certain
name instead of open-coding this in every user.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
Revision history:
v9 =3D>
 - No changes
v8 =3D> v9:
 - Drop the fwnode_for_each_available_named_child_node() as suggested
   by Sakari during v8 review:
   https://lore.kernel.org/all/Z9mQPJwnKAkPHriT@kekkonen.localdomain/
v7 =3D> v8:
 - Fix the example in fwnode_get_named_child_node_count() documentation
   to use the fwnode_get_named_child_node_count() and not the
   device_get_named_child_node_count()
 - Fix the rest of the new macro's indentiations
v6 =3D> v7:
 - Improve kerneldoc
 - Inline device_get_named_child_node_count() and change it to call
   fwnode_get_named_child_node_count() inside
 - Fix indentiation of the new macros
v5 =3D> v6:
 - Add helpers to also iterate through the nodes.
v4 =3D> v5:
 - Use given name instead of string 'channel' when counting the nodes
 - Add also fwnode_get_child_node_count_named() as suggested by Rob.
v3 =3D> v4:
 - New patch as suggested by Jonathan, see discussion in:
https://lore.kernel.org/lkml/20250223161338.5c896280@jic23-huawei/
---
 drivers/base/property.c  | 27 +++++++++++++++++++++++++++
 include/linux/property.h | 20 ++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c1392743df9c..f42f32ff45fc 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -945,6 +945,33 @@ unsigned int device_get_child_node_count(const struct =
device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_child_node_count);
=20
+/**
+ * fwnode_get_named_child_node_count - number of child nodes with given na=
me
+ * @fwnode: Node which child nodes are counted.
+ * @name: String to match child node name against.
+ *
+ * Scan child nodes and count all the nodes with a specific name. Potential
+ * 'number' -ending after the 'at sign' for scanned names is ignored.
+ * E.g.::
+ *   fwnode_get_named_child_node_count(fwnode, "channel");
+ * would match all the nodes::
+ *   channel { }, channel@0 {}, channel@0xabba {}...
+ *
+ * Return: the number of child nodes with a matching name for a given devi=
ce.
+ */
+unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle =
*fwnode,
+					       const char *name)
+{
+	struct fwnode_handle *child;
+	unsigned int count =3D 0;
+
+	fwnode_for_each_named_child_node(fwnode, child, name)
+		count++;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_named_child_node_count);
+
 bool device_dma_supported(const struct device *dev)
 {
 	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
diff --git a/include/linux/property.h b/include/linux/property.h
index e214ecd241eb..3e83babac0b0 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -167,6 +167,10 @@ struct fwnode_handle *fwnode_get_next_available_child_=
node(
 	for (child =3D fwnode_get_next_child_node(fwnode, NULL); child;	\
 	     child =3D fwnode_get_next_child_node(fwnode, child))
=20
+#define fwnode_for_each_named_child_node(fwnode, child, name)		\
+	fwnode_for_each_child_node(fwnode, child)			\
+		if (!fwnode_name_eq(child, name)) { } else
+
 #define fwnode_for_each_available_child_node(fwnode, child)		       \
 	for (child =3D fwnode_get_next_available_child_node(fwnode, NULL); child;\
 	     child =3D fwnode_get_next_available_child_node(fwnode, child))
@@ -178,11 +182,19 @@ struct fwnode_handle *device_get_next_child_node(cons=
t struct device *dev,
 	for (child =3D device_get_next_child_node(dev, NULL); child;	\
 	     child =3D device_get_next_child_node(dev, child))
=20
+#define device_for_each_named_child_node(dev, child, name)		\
+	device_for_each_child_node(dev, child)				\
+		if (!fwnode_name_eq(child, name)) { } else
+
 #define device_for_each_child_node_scoped(dev, child)			\
 	for (struct fwnode_handle *child __free(fwnode_handle) =3D	\
 		device_get_next_child_node(dev, NULL);			\
 	     child; child =3D device_get_next_child_node(dev, child))
=20
+#define device_for_each_named_child_node_scoped(dev, child, name)	\
+	device_for_each_child_node_scoped(dev, child)			\
+		if (!fwnode_name_eq(child, name)) { } else
+
 struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_hand=
le *fwnode,
 						  const char *childname);
 struct fwnode_handle *device_get_named_child_node(const struct device *dev,
@@ -210,6 +222,14 @@ int fwnode_irq_get_byname(const struct fwnode_handle *=
fwnode, const char *name);
=20
 unsigned int device_get_child_node_count(const struct device *dev);
=20
+unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle =
*fwnode,
+					       const char *name);
+static inline unsigned int device_get_named_child_node_count(const struct =
device *dev,
+							     const char *name)
+{
+	return fwnode_get_named_child_node_count(dev_fwnode(dev), name);
+}
+
 static inline int device_property_read_u8(const struct device *dev,
 					  const char *propname, u8 *val)
 {
--=20
2.49.0


--yXCZzpyh11Z9uerG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhBfEACgkQeFA3/03a
ocX+JggArPYht/Qa6R3JMf4CRb/NWWgTzx+yo4jvq9K/Jc4BfsFbsvPLxxfS5Q9m
UwTQurDIsM+hU8DuDJ14n5rg/ecWT1awuyOt9eZtFkt90YOvHOU1sqje74X0OL7E
DWYsDY6fnnd1jPBmd7IyZthy+1O4SHplT9UxeA73NQEfQKh2WS6a1+GCtthk61lB
UVK6eL/h2afMZceOkuLQSUNH6fwUhoa44l/h5eQCgGQCJdNwd2706YW0puwEZ2+x
c5OxG8xaV9LTMuFSl0HLqikIQ+kQn/5D6HQ35JcV3M0EwawikElpZqGsYD7R/9uk
lLpTvR8H5TNoebYOlUnHl+K+foVmQA==
=SkMp
-----END PGP SIGNATURE-----

--yXCZzpyh11Z9uerG--


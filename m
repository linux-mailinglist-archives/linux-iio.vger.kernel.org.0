Return-Path: <linux-iio+bounces-16976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94510A656B1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B7B17D2EF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02340187876;
	Mon, 17 Mar 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz8ARukM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B0182CD;
	Mon, 17 Mar 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226647; cv=none; b=rsGzWFoj/bgwFgbbg564DJPA1/DowTEdKG68lbOJlj26+XuhnP3JMJLq04eNRgql4LVpIN8T/BpqyXdN6I/nzYWFLM386tJdM+k1tNdz0y1mK07/PDLg30nkmuxayzdo2HU/S2vio7WB1Kslu8FDlKzE66lPRscy7tz3ldEW67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226647; c=relaxed/simple;
	bh=mplGLw3QnO7QHUtk8ViV2IhHKL6Xa3MisReIVwNOuK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/sR+0diUIuwIvRN4VfQCbzjLcimeJZAvlDjr3Vn7vcvg2F0dG7tqzegGYACmP6CFlNGf8ZhTSLvsZ2WRkdT+X7raOe7j2NM6NO4sHP3mhjTTDqY7+rWTmt/vsZ96htDR4qmDvJkvitaw7arui/yqYsqQ4+Fc9XeqpMZd/cuIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz8ARukM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so45466091fa.2;
        Mon, 17 Mar 2025 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742226644; x=1742831444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqwZiC/7WfiT8YB/Z7vCMKWICsqaRgXx67Tyd7/Yc7Y=;
        b=Mz8ARukMbwwslzDGT8UrxwofmKbMKYxpCgxatl8j1NY67YJg0jJLwMwTgmWd0qc4zG
         bHUZll5olhXEpLm5XbfyVu2i07t8HsIa/bfyanP6wfceq9DxGromocnqTjV5Is+ERD0D
         YWCAvgYI1dFtuncad8hsmgo8c8HUIM5QK7WQC/tSeglhC/yd1A0OQS3qCA5XFFyxCsOI
         PgF7nVupq4YZvv+k3TVgeURFlbr2imxmA1q4c0T5ZK0H1I+prIE7YN9TivhF0p5ESKys
         OrssObnbulAl3h/iPlHgpu67embZIpTzYGhdvXAl6Qn1gKuJXHt7v7kVMrY3zV0Oxd7y
         nA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226644; x=1742831444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqwZiC/7WfiT8YB/Z7vCMKWICsqaRgXx67Tyd7/Yc7Y=;
        b=HBfee4dZfoIkiMjNwSbn1Aujt1KxjIRAPlOSCT0fB8alNromZDRsa5Ab+y7POtdPjg
         PHky7ks0oDGeILzYt1hCEL/g2W6SOTeMqYqbH38LliLLrKBibb8Uu+6taGEJM5ndx21o
         Vq7dCAWD6ooQFUBRLGN4PoEpUKahR1+dbB1JfbioeMX3RRU7wCN7FDxIwD78YRo66WSX
         gapUIlrRq+MPu9ZEHoSSS7Xl7kWJ7JlHatTdUhpK7fbldjXNWszN/JeA/cnpDbjyi15V
         oxpViRvihl8zq28zylaIRhaBCDCk9ASGtfZM6nGw1z0fk7O16uRL2LGS/cpwQguAJP11
         NaSw==
X-Forwarded-Encrypted: i=1; AJvYcCU99xjUteal06yVXnbP2bD+Ld92CVO8iHYnkwj3xuQaP8oh8OFXkP0dPW4F1EDXsxwzSr9Jv4gDqYZv2g==@vger.kernel.org, AJvYcCVusfczTG+QtI/wZKq737FG51JGlqAzDNq+mVYGJTEEVaUaiqq53+n11U5YEPEhoS5Q5NQDwpkrcnMTlAE9@vger.kernel.org, AJvYcCWJe3mgQL2decSuqnHzRfxEHcFv19VwRkc9Ut5TI7fJEXxbTY7CcszCdxoi6JOi73P2EXEpzoP4x+TY@vger.kernel.org, AJvYcCWj5pwMYAitRulCtM5bzkIEREIHZoqxI+U1E93PGhNUPqyNClqdOZW78j+6nRnpzYPlX3apFStn@vger.kernel.org, AJvYcCXE1mZ8Ij0p8g9/Y88N0mwCOt9zId9rLIaujErkyzBvSvNRHgYHb8FeUMd9SW4Jvk3E1LL+8yo2145Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPmDnXNWfUuY8zYmELCtx/gJNWqXRAZMgDwGsWdsTjWTHfoDN
	qu1yHypijXv6+9ck0+9ffhlq6csiQokWkRD7FS6zh7x34Jrj+3oj
X-Gm-Gg: ASbGncu8Nat609eWRt1EaoSyTASho5jgNizWx54eOv2Xj5tEwczB/BdVHvAyQAFKOW8
	rU6L6PO691CT6bHLrAjyhnTMOlXHmDdlQmTHfikb+vUnXQro1hoMsNYH90AaM0luYNvPgmfueem
	GPza2m/1WjWz5QKeAnOMHTDOM2U9VoS+urbCpG0FwyLFndEUCFQz/1FjvypQ+8DHklDUbLwNzdg
	vCrI3wBosSb2pELqvykz7anE4WRoHaQq/g6IiOO+mje5dS3CwbCE+hCzhLSEkochM5GBcy7zGFW
	r+JAXV1uon77nMyVk4tnWygR8I2p7QtWngML4hN+IAKUNdtz8AI=
X-Google-Smtp-Source: AGHT+IHzqh5/8nNLCHt72i37fx00gCo6BGpf1nDqAKIYABAuhxZl3QM4MbQCBjDEBmiPRz62fUCoag==
X-Received: by 2002:a05:651c:198c:b0:30b:b956:53e5 with SMTP id 38308e7fff4ca-30c4a8631b9mr75648671fa.12.1742226643535;
        Mon, 17 Mar 2025 08:50:43 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0d2207sm16635501fa.14.2025.03.17.08.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:50:42 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:50:38 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
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
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 02/10] property: Add functions to iterate named child
Message-ID: <9c3880f74476436f39d796b5c10c540ae50b722c.1742225817.git.mazziesaccount@gmail.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bYX22rNXXSD3uTaD"
Content-Disposition: inline
In-Reply-To: <cover.1742225817.git.mazziesaccount@gmail.com>


--bYX22rNXXSD3uTaD
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
 include/linux/property.h | 24 ++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

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
index e214ecd241eb..a1856e6b714c 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -167,10 +167,18 @@ struct fwnode_handle *fwnode_get_next_available_child=
_node(
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
=20
+#define fwnode_for_each_available_named_child_node(fwnode, child, name)	\
+	fwnode_for_each_available_child_node(fwnode, child)		\
+		if (!fwnode_name_eq(child, name)) { } else
+
 struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child);
=20
@@ -178,11 +186,19 @@ struct fwnode_handle *device_get_next_child_node(cons=
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
@@ -210,6 +226,14 @@ int fwnode_irq_get_byname(const struct fwnode_handle *=
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
2.48.1


--bYX22rNXXSD3uTaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfYRM4ACgkQeFA3/03a
ocUnhQf+LJKSbW/K6uovWNUr/Z4zpcP1I7V2aLfEm+y0EQ155zL0xE8zfDxvgRjN
04xO75IU3g3X/XFtZxlRaN4gVK/yyTBaf0dj5fdim6tDDKNRivkdwCVURr9bxYop
KcJ5gKwQsJznfIxm3QinLxtsxfv0nnqb7/PTBKPJjTd7XwBCH3BJRweSvJbNr8kV
/M/rKI1nVLlHesgDMcka08sGZlJ82J8h+D7DsclHuUTYGpNgqsKvRjeNfPh0Nndv
nXiKRcY242ziphict1629pc0WXoODVXIc1LD9HPNINgF43rNjtWhpVZNbw5lLESO
TVeenVaIbYKm6ipWH52QzI2Iayn50Q==
=jE19
-----END PGP SIGNATURE-----

--bYX22rNXXSD3uTaD--


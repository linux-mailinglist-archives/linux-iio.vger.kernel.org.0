Return-Path: <linux-iio+bounces-16666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4259AA5954D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 13:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FAB166349
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED02288C6;
	Mon, 10 Mar 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTKkoM9E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407A3EA76;
	Mon, 10 Mar 2025 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611365; cv=none; b=Ez8u30hPSD3qrsb4ilpjNgrbzKyytj/Oq7C2oxmOqKdrk+75KUSKlHw/2GNAfM1zLu4+BUC3hfqxk9m0knQ4vt5znBiKFt688LNMwuu1rOgxvf7mFGg2ihZN/BaRGohUhAVwxanzxv9Pexjp+eMnpt/ntEeCLhtYZJ8UB1MmxOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611365; c=relaxed/simple;
	bh=W50C9myyD+f04dNjjlf3vCz4lf/WRKAWpjph/AEznqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtlIBXBifl2aU4+cE5A7VV24riJgFfIZmAz/tkFLSu+Pr7PESKMFaHUNofhQhcisT1oF5+CvRjSiNN42V2JMkirBTi2cebPh/FE1th1tIb3qtkBYldlKoIK3NNSvOeXnFM97mBC9nvY0rCGooAv7KWldDMfgk7gGYQZDKOrDk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTKkoM9E; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5499bd3084aso1860989e87.0;
        Mon, 10 Mar 2025 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611362; x=1742216162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqSie8Pu9UlkmTVB8KCTPHYG/3Uxc6sn89mUIbchqHc=;
        b=KTKkoM9Et51nyvxx4sHogZU+DMTla7Dv+5oNIhpdIOj9TmXYAFtKytwxzsL1GTUjcZ
         UtL+dv6n0k0wvUSakkuIDHdtWFR8kNHlVq7xhrFKtxyl4G+H6XXf6tq8dRPFNRKrq+SP
         HZtvXcVbB0kQXuXMEiJWyQgwsHOoEDCtYkhIs+Tty2rCsfRJWs0LvuqGZva2ilGXc7Lo
         x/B85THYWzWrnf6chu1Vj4IS8khoEMT2JrL/h9cf9mgL5kGqEXYMjLq/2pCxeIUqDMmU
         st+8NKJRO276RcmnOvd9z0kHJyasth8WSY3uKL4NeYNDnAnHWL/7ZytrtjmXgLATO71n
         x/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611362; x=1742216162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqSie8Pu9UlkmTVB8KCTPHYG/3Uxc6sn89mUIbchqHc=;
        b=CIctrukcSMpBfZIb57zjRb6uXDia0TNXGSEgbveRXqOzfgjxUQspGpdmJtfgac4Srp
         JB1KSCmeVptgOUfEBBT8OraVlJIwaO6ZA2OTvG2hEIuZeluvarqPGDXqcUngsv/GECdw
         uVqGEnaWEaFHoWw5Wc+ZfKiUp3MUDewuM/65IO0y2W2SiNTc7eXBwNgEe4OYtenINn2y
         PrwtoStKlvYGI04UTArlvtrUM8qTdHP7qZMUlIGpgE2FHrd07dYRsmzRZ9tAVSktJJJS
         aus1Afwt4vvNM0ApOSa/aiG93AGx/tvWD5/0FfIt80a2lmxGRFkUlDSWfaxi60zYwXxl
         OLGg==
X-Forwarded-Encrypted: i=1; AJvYcCV0W9jHQrvZz8cQMxBHBpbSYDLv4M+GZGci5bsPQD+YSGvUosLrO7I4PItiRDXjhtV0U/3MUFdj@vger.kernel.org, AJvYcCVAKb1VCeHtYhms3+IvpqsJN1NXVGnR6y1kILWKZci8HChofvrZjhZlc1qypwCsB/kNwA3ocCSPN3ytBg==@vger.kernel.org, AJvYcCVAyIYVJnBgqH6jYAQjt1yM07ktp0QZjGVqFj0yzK0mrZxEkh3kbseN/2ILzwARQCy4F1gduu1sQwFX@vger.kernel.org, AJvYcCW1WLDoWz95LLjUhRAC2xgwt3NWCPJH8KOqPKoZ/Fcekrjqz+GLCDxAOwc+jDgWqo/IqenQzyhcNmMAKnw5@vger.kernel.org, AJvYcCWuXt+Ic+6LI+7e33mD0wyKRcNoEkBedLm/8xWG973zgDIuLKOxno6KACIXGOADM/H+8EcZ58bbeh4u@vger.kernel.org
X-Gm-Message-State: AOJu0YxqrqHJeZnlbVLx4rOuHiwe+aF8mWiEhca9QKE2PRIj1WEsmAzl
	QtivqUeujaNp61XEsK6NLonTNoeYRp1w4GIFP7yBqMW8s+TEs5WF
X-Gm-Gg: ASbGncvN1XJdZoe9wi2qDpwlcLEoWpDlaVVyC9qtS6H4NXBRoTIjiceNj9aBFFDiu1I
	TDUCahE4/SxF78MtwQkB1EYVUmWNm8Ah2/FXzR7xw7CwHhRb66IaQrrP9v4hxbaPCkNPNApswds
	ms0Pz//8iAsrKurpp8FErOjnjqKdLtZ9a9RNqNu98jiW4vO+dD3lyNI4JmT2CmEtitNfm96ttAA
	PBE0jOf72tJLrlvKc2mlWSoz1l5qYMzqAf4BXsuHSN1JT6MPyxvJSktB9KvOiqvwrcjc6MhLguh
	7iSXnjJk9k8JBCJguixKRaRdEAMhSajUArVh6BTlnMWTPJu05W0=
X-Google-Smtp-Source: AGHT+IGhZSWHAvtCtWF+S1BsjEkbqrkDYmcIb4DzzzZPqCMUNu5kqWN7ZmWqkl/XnpG1SgIQ2+ZSNg==
X-Received: by 2002:a05:6512:3e2a:b0:545:114a:5618 with SMTP id 2adb3069b0e04-54990e29ba2mr4430176e87.7.1741611361580;
        Mon, 10 Mar 2025 05:56:01 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c33f1sm1442139e87.226.2025.03.10.05.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:56:00 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:55:53 +0200
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
Subject: [PATCH v6 02/10] property: Add functions to iterate named child
Message-ID: <ff924f640feeb87819d40557f12a04e607894682.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qGIIpiwQ9PmQialC"
Content-Disposition: inline
In-Reply-To: <cover.1741610847.git.mazziesaccount@gmail.com>


--qGIIpiwQ9PmQialC
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

Add a helpers for iterating and counting device's sub-nodes with certain
name instead, of open-coding this in every user.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v5 =3D> v6:
 - Add helpers to also iterate through the nodes.
v4 =3D> v5:
 - Use given name instead of string 'channel' when counting the nodes
 - Add also fwnode_get_child_node_count_named() as suggested by Rob.
v3 =3D> v4:
 - New patch as suggested by Jonathan, see discussion in:
https://lore.kernel.org/lkml/20250223161338.5c896280@jic23-huawei/

Please note, the checkpatch.pl was not happy about the for_each...()
macros. I tried to make them to follow the existing convention. I am
open to suggestions how to improve.

---
 drivers/base/property.c  | 54 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h | 20 +++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c1392743df9c..335262a894f4 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -945,6 +945,60 @@ unsigned int device_get_child_node_count(const struct =
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
+ * Scan child nodes and count all the nodes with a specific name. Return t=
he
+ * number of found nodes. Potential '@number' -ending for scanned names is
+ * ignored. Eg,
+ * device_get_child_node_count(dev, "channel");
+ * would match all the nodes:
+ * channel { }, channel@0 {}, channel@0xabba {}...
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
+/**
+ * device_get_named_child_node_count - number of child nodes with given na=
me
+ * @dev: Device to count the child nodes for.
+ * @name: String to match child node name against.
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
+ * Return: the number of child nodes with a matching name for a given devi=
ce.
+ */
+unsigned int device_get_named_child_node_count(const struct device *dev,
+					       const char *name)
+{
+	struct fwnode_handle *child;
+	unsigned int count =3D 0;
+
+	device_for_each_named_child_node(dev, child, name)
+		count++;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(device_get_named_child_node_count);
+
 bool device_dma_supported(const struct device *dev)
 {
 	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
diff --git a/include/linux/property.h b/include/linux/property.h
index e214ecd241eb..6dd9ae83e9a5 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -167,10 +167,18 @@ struct fwnode_handle *fwnode_get_next_available_child=
_node(
 	for (child =3D fwnode_get_next_child_node(fwnode, NULL); child;	\
 	     child =3D fwnode_get_next_child_node(fwnode, child))
=20
+#define fwnode_for_each_named_child_node(fwnode, child, name)		\
+		fwnode_for_each_child_node(fwnode, child)		\
+			if (!fwnode_name_eq(child, name)) { } else
+
 #define fwnode_for_each_available_child_node(fwnode, child)		       \
 	for (child =3D fwnode_get_next_available_child_node(fwnode, NULL); child;\
 	     child =3D fwnode_get_next_available_child_node(fwnode, child))
=20
+#define fwnode_for_each_available_named_child_node(fwnode, child, name)	\
+		fwnode_for_each_available_child_node(fwnode, child)	\
+			if (!fwnode_name_eq(child, name)) { } else
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
+		device_for_each_child_node(dev, child)			\
+			if (!fwnode_name_eq(child, name)) { } else
+
 #define device_for_each_child_node_scoped(dev, child)			\
 	for (struct fwnode_handle *child __free(fwnode_handle) =3D	\
 		device_get_next_child_node(dev, NULL);			\
 	     child; child =3D device_get_next_child_node(dev, child))
=20
+#define device_for_each_named_child_node_scoped(dev, child, name)	\
+		device_for_each_child_node_scoped(dev, child)		\
+			if (!fwnode_name_eq(child, name)) { } else
+
 struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_hand=
le *fwnode,
 						  const char *childname);
 struct fwnode_handle *device_get_named_child_node(const struct device *dev,
@@ -209,6 +225,10 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode,=
 unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *=
name);
=20
 unsigned int device_get_child_node_count(const struct device *dev);
+unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle =
*fwnode,
+					       const char *name);
+unsigned int device_get_named_child_node_count(const struct device *dev,
+					       const char *name);
=20
 static inline int device_property_read_u8(const struct device *dev,
 					  const char *propname, u8 *val)
--=20
2.48.1


--qGIIpiwQ9PmQialC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfO4VkACgkQeFA3/03a
ocXsFAf+LU/OMaLIK90guOZkCXVmdXWtZFayDmc2+XF+caxfZMX94Kw/Mcuk1I/M
02dvrotcuGJztwgBBt4ZGZNYBm9aJfT5Xo6F4NQkEBrTNPJlgqUbdIIhSK1udrdO
ecSH1jlN4ccNivYLjGrniD/3HD/FfrPDfejNTNyMmgtypLfigGSU671fM4Dve6Py
9xdAispXLckAx9GcI/khoMw1H/NHMwEWUl2Lk1JRNQN2mXzPgiXm4YRV67t6mger
e9VEr86Hxc4f8P4Warlt6V95nx8Mk0LUxJnHohbkULYHGL8KtE37gEYOaVD0riz2
qb0adk3zTUTrMof2AMgaKds6u5P4rQ==
=gndi
-----END PGP SIGNATURE-----

--qGIIpiwQ9PmQialC--


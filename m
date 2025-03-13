Return-Path: <linux-iio+bounces-16766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09879A5ECB0
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 08:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35D83B58D4
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 07:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529E51FC7C2;
	Thu, 13 Mar 2025 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfb6fPLd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A5B1FC102;
	Thu, 13 Mar 2025 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850292; cv=none; b=qNnScgHGMafg+1wN2pfDJms+HMhFGxLXw7astKoDViekbwATKndA2gO+ERuz4rC4ef7cFCQvLlgCjw52QrU2F7UwNhqjB7JIhtNSmbcOsCWRYL8qv/KkLnTry0O7PL9gqXns0LldjPiDPoAT/a8JU1tujcjeNiyVoQaTaDA4hsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850292; c=relaxed/simple;
	bh=f8ZnW3oO3kWzj9xDjSgBVqOoaNahbzAF5dOy2Fh++kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVorPt4uc3x1c08OM6oBTjNEcBSr2UO1F4Xs1BPCC3nQX7QVQTbjleldMw3OU7AZ5nQfnWmXGs7amE1aGCsoqWi5nUG5r51eVyj2R4YwPLEQ/rvSO96m9mRFc1QE2KD4MhHiCo9m5KAW5nNrBLP+l10tQtPLtbAql6WVGCu4Us4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zfb6fPLd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bf8f5dde5so6069751fa.2;
        Thu, 13 Mar 2025 00:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741850288; x=1742455088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6OQ0UScw9oWVqgjbWQLTmLI2FDlmbWiio4NLFE3cNQ=;
        b=Zfb6fPLdyWsgy1t5Y/eO1r5/A06bq2hp8VOMJIU5fmNwt/B8Y8SeVl/9sQMqqd1zj0
         VHDfDfkjxxZDxgvXzazHml91PErt1jn8HSDEpaqP/Wu8M5hXV9EVD7NZKLXp0oSdBab3
         3R/ahYxMeSf6Zjwgln2uD3DX4Zd/pcl3tdFCR0MQPVFoYoZrMqtYNz/3ifLUNPtDEE7H
         bteRFVnT8QfeLE8nEltIHgj2umFlV91h8By9EiWm5wS4ooP4tstKkdS9TAWnBDZDo9xo
         /xUNJtR0uFQw8Rw3LnE7gawSbMl2S4jPrKOB6zD4YhECBxOoPrdkhvuG0v7VsvDbdCSK
         hj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850288; x=1742455088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6OQ0UScw9oWVqgjbWQLTmLI2FDlmbWiio4NLFE3cNQ=;
        b=tzLAe3OW7xZQ8P6KHicmLhB0/cPei8msdiOqySh5mgJzCBN9EUjUU8N0fAf7JiRT09
         h/EbaOLc58OX32m5zmd+YZk68nlGu3yaiKlNGDB908p3Jex6nknwC756UrSMYLlk/IAd
         o8n2w3zkG441JJ/f8mCBFKemSbugI9u2CnSRabWUNsAXBgm2dr2p91A8HPbHrvITgN8r
         BTLaTIP91uKB3J5nhHlUHqjlb5M71q5CsZ4ctwGpRcE+5T27uO0FFTBdDeHim/rPat74
         SyhOgLF9zPwofftBF1N43oO6wBTxmLqvRaTEFDHzm6Zq1+tQVRf1lxv+w34vWxKCRK9v
         xDNA==
X-Forwarded-Encrypted: i=1; AJvYcCUdkldFZTMi99oZoa8BNn5u8isniCS2PwsLQMYLhF5XmwjVMiykb3RTilHSK0X1Y8Kp1ZAE1BHojPIS@vger.kernel.org, AJvYcCUsNu88Q407USJEz9E0680I7sUZjlKmoykPLn82oEEGOSN1LxBx72EjF39bD8rfKMIjenh2P5uzbQ2pGZXH@vger.kernel.org, AJvYcCWOrQy7APWxJMyFW3XSNKtwMyCH0FLeV+gzMNyFuGa2dzJS6D55xRXfN7bVR0FrjXdnMlwF9tSk@vger.kernel.org, AJvYcCWiivILHNU8zeS0bDwS7OiqlcSqqBRqEW2/RyXoyRiqm9Lf9/iVSfFBWNPK+VqFIGrdAP3eXj4JuDAGgQ==@vger.kernel.org, AJvYcCX+azUwH93afWtLXG9nKsBSac7CI5VofXysAo+61HqCykWMc/+0vlVIInl7KTftM6Jhwiit78Z3++KV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw64XQeeDrxt3ytSp1VgVYwTmRyaryGT6GKtmlY+GhDWy/90R0P
	KNyL8QpihnKiKUtJ16Dam/Z+fYqwDQ88+MvwLcjeMpfrpjFVKeWe
X-Gm-Gg: ASbGncv8SlMMltFNNhJN8DDFgYHU56z9L+R15QYgzliObLny+qon8UQEaWtV7YoSiZs
	zARsMY3V+RkS1is2o/KwhiN3vGeHW2EBjiLKlTazBPLFwRSIoUUBI9QCE7BQr79tzZAgHLNwwAI
	pyalNydcRSpsckR/8zfcMiXWdFzzfBbLhf2cV8l4KzYa/ogDUceQQ16W5a9QQOiTXunh5l0KyUE
	GSKYtpFUKw9HhWVMpiqkTQ2TXogdMf1OMhZ2pHkfW9IDVjYLRSybC+de4gaq98+XEp5Ble1BPT2
	lL0a9/LtJ1LSeDqBC3hn/TiGEDqRirt78Kl/o+/QpSJfTTgLzBw=
X-Google-Smtp-Source: AGHT+IHzZv16Eu3w2zLkjkG+6Z49HMA0c9ugl4Tm5n7/tbL2xQpVPA78kgBBEziTb7/bu9L9u95PWQ==
X-Received: by 2002:a05:6512:3da3:b0:545:8a1:536e with SMTP id 2adb3069b0e04-54990e2be7bmr8687493e87.6.1741850288124;
        Thu, 13 Mar 2025 00:18:08 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba885982sm117495e87.192.2025.03.13.00.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:18:05 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:18:00 +0200
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
Subject: [PATCH v7 02/10] property: Add functions to iterate named child
Message-ID: <f613b5f120a4dde63d28b0a2e0186dcb8dbf57ae.1741849323.git.mazziesaccount@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hxC+/1/m91rVwowg"
Content-Disposition: inline
In-Reply-To: <cover.1741849323.git.mazziesaccount@gmail.com>


--hxC+/1/m91rVwowg
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
---
Revision history:
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
index c1392743df9c..83fa0d0ee1f5 100644
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
+ *   device_get_named_child_node_count(dev, "channel");
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
index e214ecd241eb..7411dfdaadc0 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -167,10 +167,18 @@ struct fwnode_handle *fwnode_get_next_available_child=
_node(
 	for (child =3D fwnode_get_next_child_node(fwnode, NULL); child;	\
 	     child =3D fwnode_get_next_child_node(fwnode, child))
=20
+#define fwnode_for_each_named_child_node(fwnode, child, name)		\
+	fwnode_for_each_child_node(fwnode, child)		\
+		if (!fwnode_name_eq(child, name)) { } else
+
 #define fwnode_for_each_available_child_node(fwnode, child)		       \
 	for (child =3D fwnode_get_next_available_child_node(fwnode, NULL); child;\
 	     child =3D fwnode_get_next_available_child_node(fwnode, child))
=20
+#define fwnode_for_each_available_named_child_node(fwnode, child, name)	\
+	fwnode_for_each_available_child_node(fwnode, child)	\
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


--hxC+/1/m91rVwowg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfShqgACgkQeFA3/03a
ocXiDwf/W/h1A/XpbHrtKtk+cE7WbVxZCZw7Z7Pu+S2UUHEQSaQGoeNgfE8ytr9i
9UzkUd+lmnKMx3HkdQxkPvsp1KZjXb+OHOYBZzLSJEVh21vT7Wfh9t2IwGocN9Nd
RVszY3ILbBrJ52BxbZS+OS5LituC+54qGuv5sDkJwuhfBMMiRdKdlqz4GeAnv0kB
Hdh2TTzITT45oZY3Urh5xKuDIxTxP4xOkV9WOM+5FlFIXGsjtQ7g3ElM9tFG/9qo
6RBaUEMnyp1iATyz6WHpP8Y5/St5tws0xt5zGVuHR9kMl94M8ndOJVXH/hF8+bxi
Ed6BiMRmT2P/92KtNCHrw4YuF6WaxA==
=dEta
-----END PGP SIGNATURE-----

--hxC+/1/m91rVwowg--


Return-Path: <linux-iio+bounces-16261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B65DA4BEB3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731F8166514
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64891F9F72;
	Mon,  3 Mar 2025 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM4meHfM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C81F875B;
	Mon,  3 Mar 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001518; cv=none; b=srwrnt+d/caVOsL1FFZ8GVIcvJSf/6+VVdJsXm0hwZ+x/zccENiqfEC3y3Hp+MrRjjHdCcCi0prYRP/QvswtLzN6nw/DQJtIZzgkeRQnsVSuK+pRl+fM0oIkVxicbzQ2uCYm0EGkNJZESqNkNEr71pGgOT/sryNVbdLWqHsvpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001518; c=relaxed/simple;
	bh=VK+wLQ9a1YVw2InQlR9rBHrpWbLQSYD3JLURALNw+wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chWTQPtZX0lKVSn+7W3XBLBMEPSE9Lo5RRnDMsMcBjfM8u3W5Cex5oo2hkgfXeDXU/5a3rOuFuZd9A+0w+1gAnoWvMG5gQ5R5PPCuXPDhVK9t1a7tu1JoSRttt+s588f+SCHRdTZAkt67oNw7ox662hLl8+9U76MZa476Hsx+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM4meHfM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-547bcef2f96so4835828e87.1;
        Mon, 03 Mar 2025 03:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741001515; x=1741606315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3D8bLpJVMiCGePd22hG/jc8AHfF1TSUBPWzjyI39QwE=;
        b=EM4meHfMZZSCLEZL7LKramR2/ynMrUw6wxrprERQiJhvlwlkYr7/lcJ8TShDbt+S/v
         ENxqRgfr6XxgvUkDuS48OhWGNJFXDyf5eq/if91/n3SjAS+qRmz7pk+GUhoDi8YQZXP/
         5kjWpZKTXjsitkzlPAmcY0e7CTMFw8MAdWX4CkfztZhi40mkpRdwRYg3ICStfBFssmbk
         HrqzA+f3M0DUI9Rm48mM21PpDdlEi8kfVWFvcAE5YxgxA6+g/R/rYoxPDq3RUz7qolM8
         oCX2sVkuGInDBAQKceUCvVtIHgziLh0HepvpSFQEP9QF9HyhQlDPiH9MNbiIZkzvulDl
         oX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001515; x=1741606315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D8bLpJVMiCGePd22hG/jc8AHfF1TSUBPWzjyI39QwE=;
        b=GdvEkJwcQDsqJ2z8hxlQfVUPeJQmgKVFFQtLuzTWkNrgIuLMd7udHlkJEMDI2H9DF6
         D5kWYIOlG25nnter0rdhc+yvaq2U1izMt2rSWQUg5ER8+jcAez2VrLC2LmFWH+fivyhp
         cawbWKSMQIzHSco9FdMsbQmqRcVDGg7N34kyS7UBPtM/bCmfLGfGzDXOGXeKA2ND/aFo
         nl6VNdJrQ3HZPJGRIoWivCOSY5S3kZRP1o3A3GOpH/vUiEFy81ShTAQUC7NtCW0GtzbQ
         nopaf/JggwCnizSKtVV2D0/UocQD5LO49fyVtlcWnCajfkH/XhrcCgtzhdMQ4Y6R9iCa
         GMfA==
X-Forwarded-Encrypted: i=1; AJvYcCUuS+Z/JleoNKi2GL0n2im+6MyqXbd1+0UKZsY0iFl29JMzTKzEBooYsceh78FGnW9LfCw5kwEFUM2D@vger.kernel.org, AJvYcCV0pOEzAi8/XPQJDrpAhJ9mbhGt7X0g5weL37YHlndrenpa7CFKYnSdypQi+Z8PjrcUHuVDpb2m0i+p@vger.kernel.org, AJvYcCWUSMQZUkOZ8Ks4BqvZs2QbETfadWF8OI0H+S49gP87J7MaZRLjHkWdGaMclV18OyT7qamZQ6xTUlKV5Q==@vger.kernel.org, AJvYcCX5D7jDBn93sXqvB02BolO5XPInYRmBvmWy23kzZzX4//9gUfr04iKeQ2/AU32G+qv2VP9nIPa0@vger.kernel.org, AJvYcCXJV39risidGXOaY5tdC2WnqE471clJCn6O7vuDVOv2CZ3FhYpWn17G/7tetifBL6OLVJZVyroBfk8bMQ0U@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/hQFuywrO2wMeOEtDj9jnFbQ7+avsAVnzsxlri8c84pvFtpXe
	cwJAz0ro1gXMqCIXy9EgXse85sI6dw0Qv1KGy0ku+Lfj3sXen45j
X-Gm-Gg: ASbGncsl7kjXNoRBIpQiTpeoN4GM9HWucSx4ERlkiH/0wcNmK9gNhCYRyOV0KiQf+Ee
	xtMKxDx1cAyYN/q+TWSM91n0HIyHKXYK13Pgek1hrPh5WiaUnhHjfKwOy68fdO6x0K3OiO1e0GP
	j0/M4f/29TEEOCO5T4tbx1ul2mElum/WuSeqhALMWcEc6289PFVRsXqd9suo30wl1sV0jJ9dyLX
	Nzme3wFl+Q1Q32UdTGmisSCD1yLelbw1BoQ2R9JbK1+x8uHGf8SSfocQ//yi6cQsKKBAeDFv7cK
	yS2Nmcs8pahmn3o8DKVYGZTfeqer5yYjPjjr0LywsOpIPtQc/6ZADiLnuhJ/Xsr5eW0D+j6O9WL
	gWPE8qI4GjzA=
X-Google-Smtp-Source: AGHT+IFUzrwDae5itGK0Tklt3eAptl3kvZJJdnByYoCxNj7mnHlHu9IrZm0GFAEmcyC/aR//kpMwfw==
X-Received: by 2002:a05:6512:3191:b0:544:c36:3333 with SMTP id 2adb3069b0e04-5494c323660mr4969609e87.30.1741001514716;
        Mon, 03 Mar 2025 03:31:54 -0800 (PST)
Received: from mva-rohm (mobile-access-2e8451-125.dhcp.inet.fi. [46.132.81.125])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54953457ef0sm915179e87.166.2025.03.03.03.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:31:52 -0800 (PST)
Date: Mon, 3 Mar 2025 13:31:45 +0200
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
Subject: [PATCH v5 02/10] property: Add functions to count named child nodes
Message-ID: <5e35f44db2b4ed43f75c4c53fd0576df9ad24ab2.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kzKPySHPwn0pN7fg"
Content-Disposition: inline
In-Reply-To: <cover.1740993491.git.mazziesaccount@gmail.com>


--kzKPySHPwn0pN7fg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are some use-cases where child nodes with a specific name need to
be parsed. In a few cases the data from the found nodes is added to an
array which is allocated based on the number of found nodes. One example
of such use is the IIO subsystem's ADC channel nodes, where the relevant
nodes are named as channel[@N].

Add a helpers for counting device's sub-nodes with certain name instead
of open-coding this in every user.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v4 =3D> v5:
 - Use given name instead of string 'channel' when counting the nodes
 - Add also fwnode_get_child_node_count_named() as suggested by Rob.
v3 =3D> v4:
 - New patch as suggested by Jonathan, see discussion in:
https://lore.kernel.org/lkml/20250223161338.5c896280@jic23-huawei/
---
 drivers/base/property.c  | 57 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  4 +++
 2 files changed, 61 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c1392743df9c..3faf02b99cff 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -945,6 +945,63 @@ unsigned int device_get_child_node_count(const struct =
device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_child_node_count);
=20
+/**
+ * fwnode_get_child_node_count_named - number of child nodes with given na=
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
+unsigned int fwnode_get_child_node_count_named(const struct fwnode_handle =
*fwnode,
+					       const char *name)
+{
+	struct fwnode_handle *child;
+	unsigned int count =3D 0;
+
+	fwnode_for_each_child_node(fwnode, child)
+		if (fwnode_name_eq(child, name))
+			count++;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_child_node_count_named);
+
+/**
+ * device_get_child_node_count_named - number of child nodes with given na=
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
+unsigned int device_get_child_node_count_named(const struct device *dev,
+					       const char *name)
+{
+	const struct fwnode_handle *fwnode =3D dev_fwnode(dev);
+
+	if (!fwnode)
+		return -EINVAL;
+
+	if (IS_ERR(fwnode))
+		return PTR_ERR(fwnode);
+
+	return fwnode_get_child_node_count_named(fwnode, name);
+}
+EXPORT_SYMBOL_GPL(device_get_child_node_count_named);
+
 bool device_dma_supported(const struct device *dev)
 {
 	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
diff --git a/include/linux/property.h b/include/linux/property.h
index e214ecd241eb..269ab539515b 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -209,6 +209,10 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode,=
 unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *=
name);
=20
 unsigned int device_get_child_node_count(const struct device *dev);
+unsigned int fwnode_get_child_node_count_named(const struct fwnode_handle =
*fwnode,
+					       const char *name);
+unsigned int device_get_child_node_count_named(const struct device *dev,
+					       const char *name);
=20
 static inline int device_property_read_u8(const struct device *dev,
 					  const char *propname, u8 *val)
--=20
2.48.1


--kzKPySHPwn0pN7fg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfFkyEACgkQeFA3/03a
ocVk2Af9Hyi2V4kPlX2y9PP8vv7cf2CaFwFcKaEb3wF4abK7xl/p1iuy5t2IKYP+
xgpqzjOxRv5nqsftTbERgHalh/VTfmMLsinD1WwV0GnJTjI0z8GojbTQoLAv4aet
ZX9ruqK1cdteuVCQBf/dBhVVEqXf8btU2z39yzIzyfCi0l9MKj1PHph8xkwoCI6W
tFMY3vyE8EgQmT6O+nNrMBSZsiqFu/ETBhYW6cwSOWDaHDXlkRX1IKZO4kvbLNdq
/TckUxLhYFNoU98fXqxuKRI2X4/8demRz6typqEKEhLHHsy2cqGGDtPIjrwnbrU5
97WE6ObjRcyOl8NLpwE/mDXlPWT03A==
=vOx6
-----END PGP SIGNATURE-----

--kzKPySHPwn0pN7fg--


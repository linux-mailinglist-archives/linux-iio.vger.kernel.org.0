Return-Path: <linux-iio+bounces-4543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003F28B3BE3
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 17:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA41D283A64
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D915624D;
	Fri, 26 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJdkianv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3514AD30;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146149; cv=none; b=VCQISMed5CMYpw+e+q4l/vl43XO+s8abufzRt/VoUN+m0Tu9enk3jkqpPZnxcBBVeAS0R+Stpr7IsfeNYo51JmYdIN28wS8eldi6BEjFeLp/rSYwM/5tqUuAK9o5jdAY1ATpZSMcgg736W9RTBxJWmW1Om5tq2nf8XDjUs4wmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146149; c=relaxed/simple;
	bh=JiNjdPNxj4XphqoUbNiF6vlkEV4mojbalqzcwjY4iMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8xLEHfwj95nbcG2i5OtLkY7mBL30IJ1H/BDvMNlieR8LJaDbHrCHYH+xfIEpfhStPnv64a3FkAC6vP2dopTVNrJCSdCcTC2GaxtbHr+prprCKpA8cLNGYWTulLDKpePPMRWhERtVvM47LUZy80c9YJRxfOpXQXpnHINDxff04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJdkianv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71D81C116B1;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714146149;
	bh=JiNjdPNxj4XphqoUbNiF6vlkEV4mojbalqzcwjY4iMc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jJdkianvnjqfciNIEOIGjGojAOgwFXiPIRgUwFg3Q0ZQtLr/nnAtl856TE7UJrSRg
	 DmwH5WOk8clfXY4SuH/PP5ld9dwiswMOOoTMsEZLhxn3fORqMly5KGHi+21nsWgUyx
	 R/QKcKXIGqLTlCDIx6Qerc1Qkb0+Ts6pzt6pEEZZDIs/PN5hCoaQBctzDDN2YsbaLZ
	 LeUhAwtgMXJ4DNJjD+pMocqajd5+2V+8xUgNBXigzd3iX5VGm08bjdKmJeeK9c2Zhu
	 0Yq7PkU3pLNZWx4PBQ5DbLKTVYrlrA6w3lVhxzRjS2uKOKItkBibUmUTWsjBG0PyP7
	 t4KKQyocPmN4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695CEC25B4F;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Apr 2024 17:42:10 +0200
Subject: [PATCH v2 1/7] iio: backend: change docs padding
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-ad9467-new-features-v2-1-6361fc3ba1cc@analog.com>
References: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
In-Reply-To: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714146147; l=9346;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=dqEqcsoqR5bEdYlGMpM4Yqp9dr2hRNwIiyyj5IVyzo8=;
 b=GT7p0JASWbMoeTWS8vM2J8oK9gC/qyWrnGJ0p4MIqGetiy/m7msLGJoHdHGZ6ZwI5cdEMS8hh
 FM7xjmDYkH1CwXxEj/qP4CzM3yLZ7OXERM2ZO0RumAP/D8YCYr1hDDe
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Using tabs and maintaining the start of the docs aligned is a pain and
may lead to lot's of unrelated changes when adding new members. Hence,
let#s change things now and just have a simple space after the member
name.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 76 +++++++++++++++++++-------------------
 include/linux/iio/backend.h        | 38 +++++++++----------
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index f08ed6d70ae5..c27243e88462 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -115,8 +115,8 @@ static DEFINE_MUTEX(iio_back_lock);
 
 /**
  * iio_backend_chan_enable - Enable a backend channel
- * @back:	Backend device
- * @chan:	Channel number
+ * @back: Backend device
+ * @chan: Channel number
  *
  * RETURNS:
  * 0 on success, negative error number on failure.
@@ -129,8 +129,8 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_chan_enable, IIO_BACKEND);
 
 /**
  * iio_backend_chan_disable - Disable a backend channel
- * @back:	Backend device
- * @chan:	Channel number
+ * @back: Backend device
+ * @chan: Channel number
  *
  * RETURNS:
  * 0 on success, negative error number on failure.
@@ -148,8 +148,8 @@ static void __iio_backend_disable(void *back)
 
 /**
  * devm_iio_backend_enable - Device managed backend enable
- * @dev:	Consumer device for the backend
- * @back:	Backend device
+ * @dev: Consumer device for the backend
+ * @back: Backend device
  *
  * RETURNS:
  * 0 on success, negative error number on failure.
@@ -168,9 +168,9 @@ EXPORT_SYMBOL_NS_GPL(devm_iio_backend_enable, IIO_BACKEND);
 
 /**
  * iio_backend_data_format_set - Configure the channel data format
- * @back:	Backend device
- * @chan:	Channel number
- * @data:	Data format
+ * @back: Backend device
+ * @chan: Channel number
+ * @data: Data format
  *
  * Properly configure a channel with respect to the expected data format. A
  * @struct iio_backend_data_fmt must be passed with the settings.
@@ -190,9 +190,9 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_format_set, IIO_BACKEND);
 
 /**
  * iio_backend_data_source_set - Select data source
- * @back:	Backend device
- * @chan:	Channel number
- * @data:	Data source
+ * @back: Backend device
+ * @chan: Channel number
+ * @data: Data source
  *
  * A given backend may have different sources to stream/sync data. This allows
  * to choose that source.
@@ -212,9 +212,9 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_source_set, IIO_BACKEND);
 
 /**
  * iio_backend_set_sampling_freq - Set channel sampling rate
- * @back:		Backend device
- * @chan:		Channel number
- * @sample_rate_hz:	Sample rate
+ * @back: Backend device
+ * @chan: Channel number
+ * @sample_rate_hz: Sample rate
  *
  * RETURNS:
  * 0 on success, negative error number on failure.
@@ -235,9 +235,9 @@ static void iio_backend_free_buffer(void *arg)
 
 /**
  * devm_iio_backend_request_buffer - Device managed buffer request
- * @dev:	Consumer device for the backend
- * @back:	Backend device
- * @indio_dev:	IIO device
+ * @dev: Consumer device for the backend
+ * @back: Backend device
+ * @indio_dev: IIO device
  *
  * Request an IIO buffer from the backend. The type of the buffer (typically
  * INDIO_BUFFER_HARDWARE) is up to the backend to decide. This is because,
@@ -300,10 +300,10 @@ static struct iio_backend *iio_backend_from_indio_dev_parent(const struct device
 
 /**
  * iio_backend_ext_info_get - IIO ext_info read callback
- * @indio_dev:	IIO device
- * @private:	Data private to the driver
- * @chan:	IIO channel
- * @buf:	Buffer where to place the attribute data
+ * @indio_dev: IIO device
+ * @private: Data private to the driver
+ * @chan: IIO channel
+ * @buf: Buffer where to place the attribute data
  *
  * This helper is intended to be used by backends that extend an IIO channel
  * (through iio_backend_extend_chan_spec()) with extended info. In that case,
@@ -335,11 +335,11 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_get, IIO_BACKEND);
 
 /**
  * iio_backend_ext_info_set - IIO ext_info write callback
- * @indio_dev:	IIO device
- * @private:	Data private to the driver
- * @chan:	IIO channel
- * @buf:	Buffer holding the sysfs attribute
- * @len:	Buffer length
+ * @indio_dev: IIO device
+ * @private: Data private to the driver
+ * @chan: IIO channel
+ * @buf: Buffer holding the sysfs attribute
+ * @len: Buffer length
  *
  * This helper is intended to be used by backends that extend an IIO channel
  * (trough iio_backend_extend_chan_spec()) with extended info. In that case,
@@ -365,9 +365,9 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
 
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
- * @indio_dev:	IIO device
- * @back:	Backend device
- * @chan:	IIO channel
+ * @indio_dev: IIO device
+ * @back: Backend device
+ * @chan: IIO channel
  *
  * Some backends may have their own functionalities and hence capable of
  * extending a frontend's channel.
@@ -449,8 +449,8 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
 
 /**
  * devm_iio_backend_get - Device managed backend device get
- * @dev:	Consumer device for the backend
- * @name:	Backend name
+ * @dev: Consumer device for the backend
+ * @name: Backend name
  *
  * Get's the backend associated with @dev.
  *
@@ -501,8 +501,8 @@ EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, IIO_BACKEND);
 
 /**
  * __devm_iio_backend_get_from_fwnode_lookup - Device managed fwnode backend device get
- * @dev:	Consumer device for the backend
- * @fwnode:	Firmware node of the backend device
+ * @dev: Consumer device for the backend
+ * @fwnode: Firmware node of the backend device
  *
  * Search the backend list for a device matching @fwnode.
  * This API should not be used and it's only present for preventing the first
@@ -536,7 +536,7 @@ EXPORT_SYMBOL_NS_GPL(__devm_iio_backend_get_from_fwnode_lookup, IIO_BACKEND);
 
 /**
  * iio_backend_get_priv - Get driver private data
- * @back:	Backend device
+ * @back: Backend device
  */
 void *iio_backend_get_priv(const struct iio_backend *back)
 {
@@ -554,9 +554,9 @@ static void iio_backend_unregister(void *arg)
 
 /**
  * devm_iio_backend_register - Device managed backend device register
- * @dev:	Backend device being registered
- * @ops:	Backend ops
- * @priv:	Device private data
+ * @dev: Backend device being registered
+ * @ops: Backend ops
+ * @priv: Device private data
  *
  * @ops is mandatory. Not providing it results in -EINVAL.
  *
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 9d144631134d..e3e62f65db14 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -24,9 +24,9 @@ enum iio_backend_data_source {
 
 /**
  * IIO_BACKEND_EX_INFO - Helper for an IIO extended channel attribute
- * @_name:	Attribute name
- * @_shared:	Whether the attribute is shared between all channels
- * @_what:	Data private to the driver
+ * @_name: Attribute name
+ * @_shared: Whether the attribute is shared between all channels
+ * @_what: Data private to the driver
  */
 #define IIO_BACKEND_EX_INFO(_name, _shared, _what) {	\
 	.name = (_name),				\
@@ -38,10 +38,10 @@ enum iio_backend_data_source {
 
 /**
  * struct iio_backend_data_fmt - Backend data format
- * @type:		Data type.
- * @sign_extend:	Bool to tell if the data is sign extended.
- * @enable:		Enable/Disable the data format module. If disabled,
- *			not formatting will happen.
+ * @type: Data type.
+ * @sign_extend: Bool to tell if the data is sign extended.
+ * @enable: Enable/Disable the data format module. If disabled,
+ *	    not formatting will happen.
  */
 struct iio_backend_data_fmt {
 	enum iio_backend_data_type type;
@@ -51,18 +51,18 @@ struct iio_backend_data_fmt {
 
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
- * @enable:		Enable backend.
- * @disable:		Disable backend.
- * @chan_enable:	Enable one channel.
- * @chan_disable:	Disable one channel.
- * @data_format_set:	Configure the data format for a specific channel.
- * @data_source_set:	Configure the data source for a specific channel.
- * @set_sample_rate:	Configure the sampling rate for a specific channel.
- * @request_buffer:	Request an IIO buffer.
- * @free_buffer:	Free an IIO buffer.
- * @extend_chan_spec:	Extend an IIO channel.
- * @ext_info_set:	Extended info setter.
- * @ext_info_get:	Extended info getter.
+ * @enable: Enable backend.
+ * @disable: Disable backend.
+ * @chan_enable: Enable one channel.
+ * @chan_disable: Disable one channel.
+ * @data_format_set: Configure the data format for a specific channel.
+ * @data_source_set: Configure the data source for a specific channel.
+ * @set_sample_rate: Configure the sampling rate for a specific channel.
+ * @request_buffer: Request an IIO buffer.
+ * @free_buffer: Free an IIO buffer.
+ * @extend_chan_spec: Extend an IIO channel.
+ * @ext_info_set: Extended info setter.
+ * @ext_info_get: Extended info getter.
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);

-- 
2.44.0




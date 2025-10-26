Return-Path: <linux-iio+bounces-25443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97786C0A1E0
	for <lists+linux-iio@lfdr.de>; Sun, 26 Oct 2025 03:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FE818A3D31
	for <lists+linux-iio@lfdr.de>; Sun, 26 Oct 2025 02:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A7223D7F2;
	Sun, 26 Oct 2025 02:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dC4KVKMT"
X-Original-To: linux-iio@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622B20DD48;
	Sun, 26 Oct 2025 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761446886; cv=none; b=ilvy56Ag/tgMGWK/BVqgqMbldnSAO9QmatfvbkJDu61ygHIawSbTamtLlYA6fanHOODnYWbNqPoSBUmFiCR/LcNCRFlH2/314CbEXABjdEFBsOteTf/1DM/xvMMDRkQlArvVM+kYasPCE0OLqyHWBfHGdMxGFbBEWRuhnZg6YHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761446886; c=relaxed/simple;
	bh=BdC6IVQByFlAwpunF3sHO1HRVXcj0fCi+U3mhEdS+kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RAPSPqDZIOPOJ0gjIX+Mbp+7OkbbRLUmBjDwgOTSARx5cexwFKCHXGsQRBY+ItIlZJhbdw1t95l5g30xG6QCLctr1c3++3kVsN4GZ7wmYM2/xTdeOJ4L+ELsxD8a9W9Su6gpGeuhA734sc5smDNcQXxM+Zg132Xeq9cF/QCfRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dC4KVKMT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=e/FjdbomwXXA5DVpijLHktilymfOdPctOT0G+OIHjkI=; b=dC4KVKMT3pzfc9sdJSZydWmZHW
	6AsgRpT514DwQqIW98PXk9CEwC13r4EJcnEsTfcKiTWI0dJSa4LGbtjIW8GQO8ILCi5bqOEorK3x4
	X/M+P6JAndDIFGa2DbAnOUsDTFQxAWqR5yolSQ6bH4YY/JRYFV2nGFQQfCBcdDE8Dur0kQtSNOY0+
	hPrpPLXlDwLnDb1v5CE90hkeJu/dtSTWg4hA+16kwKs7ygO1rhCssvy8QgEtERBKmgcHfjFH74CgO
	xJHvb0MvmLUW6mcPpRJbwcjDo/LpWZ1swToXSmwa9B4euxHXucw/uSdLKpfVzj+ndRNnDHIcjadWi
	P9PKiwRA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCqnY-0000000Bx2G-2UvL;
	Sun, 26 Oct 2025 02:48:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: adis: fix all kernel-doc warnings in header file
Date: Sat, 25 Oct 2025 19:47:59 -0700
Message-ID: <20251026024759.433956-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Correct and add to adis.h to resolve all kernel-doc warnings:

- add a missing struct member description
- change one non-kernel-doc comment to use /* instead of /**
- correct function parameter @value to @val (7 locations)
- add function return value comments (13 locations)

Warning: include/linux/iio/imu/adis.h:97 struct member 'has_fifo'
 not described in 'adis_data'
Warning: include/linux/iio/imu/adis.h:139 Incorrect use of kernel-doc
 format: * The state_lock is meant to be used during operations that
 require
Warning: include/linux/iio/imu/adis.h:158 struct member '"__adis_"'
 not described in 'adis'
Warning: include/linux/iio/imu/adis.h:264 function parameter 'val'
 not described in 'adis_write_reg'
Warning: include/linux/iio/imu/adis.h:371 No description found for
 return value of 'adis_update_bits_base'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
---
 include/linux/iio/imu/adis.h |   45 ++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 9 deletions(-)

--- linux-next-20251024.orig/include/linux/iio/imu/adis.h
+++ linux-next-20251024/include/linux/iio/imu/adis.h
@@ -57,6 +57,7 @@ struct adis_timeout {
  * @enable_irq: Hook for ADIS devices that have a special IRQ enable/disable
  * @unmasked_drdy: True for devices that cannot mask/unmask the data ready pin
  * @has_paging: True if ADIS device has paged registers
+ * @has_fifo: True if ADIS device has a hardware FIFO
  * @burst_reg_cmd:	Register command that triggers burst
  * @burst_len:		Burst size in the SPI RX buffer. If @burst_max_len is defined,
  *			this should be the minimum size supported by the device.
@@ -136,7 +137,7 @@ struct adis {
 	const struct adis_data	*data;
 	unsigned int		burst_extra_len;
 	const struct adis_ops	*ops;
-	/**
+	/*
 	 * The state_lock is meant to be used during operations that require
 	 * a sequence of SPI R/W in order to protect the SPI transfer
 	 * information (fields 'xfer', 'msg' & 'current_page') between
@@ -166,7 +167,7 @@ int __adis_reset(struct adis *adis);
  * adis_reset() - Reset the device
  * @adis: The adis device
  *
- * Returns 0 on success, a negative error code otherwise
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int adis_reset(struct adis *adis)
 {
@@ -183,7 +184,9 @@ int __adis_read_reg(struct adis *adis, u
  * __adis_write_reg_8() - Write single byte to a register (unlocked)
  * @adis: The adis device
  * @reg: The address of the register to be written
- * @value: The value to write
+ * @val: The value to write
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int __adis_write_reg_8(struct adis *adis, unsigned int reg,
 				     u8 val)
@@ -195,7 +198,9 @@ static inline int __adis_write_reg_8(str
  * __adis_write_reg_16() - Write 2 bytes to a pair of registers (unlocked)
  * @adis: The adis device
  * @reg: The address of the lower of the two registers
- * @value: Value to be written
+ * @val: Value to be written
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int __adis_write_reg_16(struct adis *adis, unsigned int reg,
 				      u16 val)
@@ -207,7 +212,9 @@ static inline int __adis_write_reg_16(st
  * __adis_write_reg_32() - write 4 bytes to four registers (unlocked)
  * @adis: The adis device
  * @reg: The address of the lower of the four register
- * @value: Value to be written
+ * @val: Value to be written
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int __adis_write_reg_32(struct adis *adis, unsigned int reg,
 				      u32 val)
@@ -220,6 +227,8 @@ static inline int __adis_write_reg_32(st
  * @adis: The adis device
  * @reg: The address of the lower of the two registers
  * @val: The value read back from the device
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int __adis_read_reg_16(struct adis *adis, unsigned int reg,
 				     u16 *val)
@@ -239,6 +248,8 @@ static inline int __adis_read_reg_16(str
  * @adis: The adis device
  * @reg: The address of the lower of the two registers
  * @val: The value read back from the device
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int __adis_read_reg_32(struct adis *adis, unsigned int reg,
 				     u32 *val)
@@ -257,8 +268,10 @@ static inline int __adis_read_reg_32(str
  * adis_write_reg() - write N bytes to register
  * @adis: The adis device
  * @reg: The address of the lower of the two registers
- * @value: The value to write to device (up to 4 bytes)
+ * @val: The value to write to device (up to 4 bytes)
  * @size: The size of the @value (in bytes)
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int adis_write_reg(struct adis *adis, unsigned int reg,
 				 unsigned int val, unsigned int size)
@@ -273,6 +286,8 @@ static inline int adis_write_reg(struct
  * @reg: The address of the lower of the two registers
  * @val: The value read back from the device
  * @size: The size of the @val buffer
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static int adis_read_reg(struct adis *adis, unsigned int reg,
 			 unsigned int *val, unsigned int size)
@@ -285,7 +300,9 @@ static int adis_read_reg(struct adis *ad
  * adis_write_reg_8() - Write single byte to a register
  * @adis: The adis device
  * @reg: The address of the register to be written
- * @value: The value to write
+ * @val: The value to write
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int adis_write_reg_8(struct adis *adis, unsigned int reg,
 				   u8 val)
@@ -297,7 +314,9 @@ static inline int adis_write_reg_8(struc
  * adis_write_reg_16() - Write 2 bytes to a pair of registers
  * @adis: The adis device
  * @reg: The address of the lower of the two registers
- * @value: Value to be written
+ * @val: Value to be written
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int adis_write_reg_16(struct adis *adis, unsigned int reg,
 				    u16 val)
@@ -309,7 +328,9 @@ static inline int adis_write_reg_16(stru
  * adis_write_reg_32() - write 4 bytes to four registers
  * @adis: The adis device
  * @reg: The address of the lower of the four register
- * @value: Value to be written
+ * @val: Value to be written
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int adis_write_reg_32(struct adis *adis, unsigned int reg,
 				    u32 val)
@@ -322,6 +343,8 @@ static inline int adis_write_reg_32(stru
  * @adis: The adis device
  * @reg: The address of the lower of the two registers
  * @val: The value read back from the device
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int adis_read_reg_16(struct adis *adis, unsigned int reg,
 				   u16 *val)
@@ -341,6 +364,8 @@ static inline int adis_read_reg_16(struc
  * @adis: The adis device
  * @reg: The address of the lower of the two registers
  * @val: The value read back from the device
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
 				   u32 *val)
@@ -366,6 +391,8 @@ int __adis_update_bits_base(struct adis
  * @size: Size of the register to update
  *
  * Updates the desired bits of @reg in accordance with @mask and @val.
+ *
+ * Returns: %0 on success, a negative error code otherwise
  */
 static inline int adis_update_bits_base(struct adis *adis, unsigned int reg,
 					const u32 mask, const u32 val, u8 size)


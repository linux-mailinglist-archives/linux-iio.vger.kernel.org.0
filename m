Return-Path: <linux-iio+bounces-22266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8C2B19F48
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 12:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41817AD386
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48D24E4D4;
	Mon,  4 Aug 2025 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FXSVU6mF"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B278E24677F;
	Mon,  4 Aug 2025 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301794; cv=none; b=DR/1wfKvo4f7qvY0NEKJAAme6ZIUZaG/LbvxVdZkZMMWXKoo0UR9ZCcyXt921/EV2X1b4lkIaPP9wBE0PvTYpOnyap6yU3GZO4070LVrA4mMhqYtjFSLN+hrOF/hkn3Tqlxia4+8Xq3FIhl6L0y3ZMr6NCagD6LrLKLN86q1dVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301794; c=relaxed/simple;
	bh=GoN/D1fysbMjHLdBfvRUxq+AyYb+K0pTz06myBTGEEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsNU7Zo54neQkh9YF2AliQVjfeEE0agYeeP+iLCaBHHH3J6nae64hJyG85x0elIoTMS112SnPxjBWb7VZ00Okb8BjnJSSZ9y3+dW9CsJ1ARFxXVpzZJrS8kAlCg1TjV39A7J6W8A1RatXm9BhoRrvAJRUh3kaIA+xC2hC2BPy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FXSVU6mF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754301792; x=1785837792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GoN/D1fysbMjHLdBfvRUxq+AyYb+K0pTz06myBTGEEQ=;
  b=FXSVU6mFSxDxClNn/l5OQyJIuczlrZadCJrPBxC1f+XfDlvrG+p1A7hJ
   ZyrZZn3RDoQ8t7ROOAw/jHunsmnPZSzWP6cH3DvnA27MVlGAlUl/UBCkO
   qP2yjGgMJfcuXh8aizu1L8RCfP6OrKDTFf1CGCjg8bIlU+mnX4ZwUsuYA
   n3mWCdThlQWqo1YVzoeTVJVSXZ2ys3//KMbkjIvtrh8T/vXEeI1Oz6ESq
   UlcwFMwosu6yDt3YvzoDYSWFhyxUN30ePI/JERDTZW9ynXfo366nPoPFD
   8W5Vz+2gjtuP7q52OdXwrrAA/589u/OMOHBRW+vkSnOszSgCLL9u0tBs7
   w==;
X-CSE-ConnectionGUID: Liqowa5KRuKZ85yXFKRAhg==
X-CSE-MsgGUID: QJiDf9GrRGW3RZ2GGFZX4A==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="50182871"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2025 03:03:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 4 Aug 2025 03:02:41 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 4 Aug 2025 03:02:35 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH 02/15] nvmem: microchip-otpc: rework to access packets based on tag
Date: Mon, 4 Aug 2025 15:32:06 +0530
Message-ID: <20250804100219.63325-3-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804100219.63325-1-varshini.rajendran@microchip.com>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Rework the driver to change the packet access technique based on the TAG
instead of the currently in use "id".

Since there is no way of knowing the OTP memory mapping in advance or the
changes it can go through with time, the id based approach is not reliable.
Accessing the packets based on the associated tags is a fail-proof
approach. This method is aided by adding a table of contents to store the
payload information which makes it easier to traverse through the OTP
memory and read the data of the intended packet. The stride of the nvmem
device is adjusted to 1 to support the TAG being treated as an offset.
The only reliable way to recognize a packet without being aware of the
flashed contents of the OTP memory is the TAG of the packet.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/nvmem/microchip-otpc.c | 130 +++++++++++++++++++++++++--------
 1 file changed, 101 insertions(+), 29 deletions(-)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index df979e8549fd..e922c882af72 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -18,16 +18,27 @@
 #define MCHP_OTPC_CR_READ		BIT(6)
 #define MCHP_OTPC_MR			(0x4)
 #define MCHP_OTPC_MR_ADDR		GENMASK(31, 16)
+#define MCHP_OTPC_MR_EMUL		BIT(7)
 #define MCHP_OTPC_AR			(0x8)
 #define MCHP_OTPC_SR			(0xc)
 #define MCHP_OTPC_SR_READ		BIT(6)
 #define MCHP_OTPC_HR			(0x20)
 #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
+#define MCHP_OTPC_HR_PACKET_TYPE	GENMASK(2, 0)
 #define MCHP_OTPC_DR			(0x24)
 
 #define MCHP_OTPC_NAME			"mchp-otpc"
 #define MCHP_OTPC_SIZE			(11 * 1024)
 
+enum packet_type {
+	PACKET_TYPE_REGULAR = 1,
+	PACKET_TYPE_KEY	= 2,
+	PACKET_TYPE_BOOT_CONFIG = 3,
+	PACKET_TYPE_SECURE_BOOT_CONFIG = 4,
+	PACKET_TYPE_HARDWARE_CONFIG = 5,
+	PACKET_TYPE_CUSTOM = 6,
+};
+
 /**
  * struct mchp_otpc - OTPC private data structure
  * @base: base address
@@ -42,6 +53,25 @@ struct mchp_otpc {
 	u32 npackets;
 };
 
+/**
+ * struct mchp_otpc_payload_info - OTP packet's payload information
+ *				retrieved from the packet's header
+ * @id: driver assigned packet ID
+ * @packet_offset: offset address of the packet to be written in the
+ *			register OTPC_MR.ADDR to access the packet
+ * @payload_length: length of the packet's payload
+ * @packet_type: type of the packet
+ * @packet_tag: TAG corresponding to the packet. Applicable for most
+ *		of the regular packets
+ */
+struct mchp_otpc_payload_info {
+	u32 id;
+	u32 packet_offset;
+	u32 payload_length;
+	u32 packet_type;
+	u32 packet_tag;
+};
+
 /**
  * struct mchp_otpc_packet - OTPC packet data structure
  * @list: list head
@@ -50,20 +80,16 @@ struct mchp_otpc {
  */
 struct mchp_otpc_packet {
 	struct list_head list;
-	u32 id;
-	u32 offset;
+	struct mchp_otpc_payload_info payload_info;
 };
 
-static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
-						       u32 id)
+static struct mchp_otpc_packet *mchp_otpc_tag_to_packet(struct mchp_otpc *otpc,
+							u32 tag)
 {
 	struct mchp_otpc_packet *packet;
 
-	if (id >= otpc->npackets)
-		return NULL;
-
 	list_for_each_entry(packet, &otpc->packets, list) {
-		if (packet->id == id)
+		if (packet->payload_info.packet_tag == tag)
 			return packet;
 	}
 
@@ -140,8 +166,27 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
  * offset returned by hardware.
  *
  * For this, the read function will return the first requested bytes in the
- * packet. The user will have to be aware of the memory footprint before doing
- * the read request.
+ * packet. The user won't have to be aware of the memory footprint before doing
+ * the read request since it is abstracted and taken care by this driver.
+ *
+ * There is no way of knowing the Mapping of the OTP memory table in advance. In
+ * this read function the offset requested is treated as the identifier string
+ * i.e., Packet TAG, to acquire the payload with reliability. The packet Tag
+ * is the only way to recognize a packet without being aware of the flashed
+ * OTP memory map table.
+ */
+
+/**
+ * mchp_otpc_read() - Read the OTP packets and fill the buffer based on the TAG
+ *		      of the packet treated as the offset.
+ * @priv: Pointer to device structure.
+ * @off: offset of the OTP packet to be read. In this case, the TAG of the
+ *	 corresponding packet.
+ * @val: Pointer to data buffer
+ * @bytes: length of the buffer
+ *
+ * A value of zero will be returned on success, a negative errno will be
+ * returned in error cases.
  */
 static int mchp_otpc_read(void *priv, unsigned int off, void *val,
 			  size_t bytes)
@@ -154,30 +199,23 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
 	int ret, payload_size;
 
 	/*
-	 * We reach this point with off being multiple of stride = 4 to
-	 * be able to cross the subsystem. Inside the driver we use continuous
-	 * unsigned integer numbers for packet id, thus divide off by 4
-	 * before passing it to mchp_otpc_id_to_packet().
+	 * From this point the packet tag received as the offset has to be translated
+	 * into the actual packet. For this we traverse the table of contents stored
+	 * in a list "packet" and look for the tag.
 	 */
-	packet = mchp_otpc_id_to_packet(otpc, off / 4);
+
+	packet = mchp_otpc_tag_to_packet(otpc, off);
 	if (!packet)
 		return -EINVAL;
-	offset = packet->offset;
+	offset = packet->payload_info.packet_offset;
 
-	while (len < bytes) {
+	if (len < bytes) {
 		ret = mchp_otpc_prepare_read(otpc, offset);
 		if (ret)
 			return ret;
 
-		/* Read and save header content. */
-		*buf++ = readl_relaxed(otpc->base + MCHP_OTPC_HR);
-		len += sizeof(*buf);
-		offset++;
-		if (len >= bytes)
-			break;
-
 		/* Read and save payload content. */
-		payload_size = FIELD_GET(MCHP_OTPC_HR_SIZE, *(buf - 1));
+		payload_size = packet->payload_info.payload_length;
 		writel_relaxed(0UL, otpc->base + MCHP_OTPC_AR);
 		do {
 			*buf++ = readl_relaxed(otpc->base + MCHP_OTPC_DR);
@@ -190,6 +228,20 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
 	return 0;
 }
 
+static int mchp_otpc_read_packet_tag(struct mchp_otpc *otpc, unsigned int offset, unsigned int *val)
+{
+	int ret;
+
+	ret = mchp_otpc_prepare_read(otpc, offset);
+	if (ret)
+		return ret;
+
+	writel_relaxed(0UL, otpc->base + MCHP_OTPC_AR);
+	*val = readl_relaxed(otpc->base + MCHP_OTPC_DR);
+
+	return 0;
+}
+
 static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
 {
 	struct mchp_otpc_packet *packet;
@@ -213,8 +265,15 @@ static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
 		if (!packet)
 			return -ENOMEM;
 
-		packet->id = id++;
-		packet->offset = word_pos;
+		packet->payload_info.id = id++;
+		packet->payload_info.packet_offset = word_pos;
+		packet->payload_info.payload_length = payload_size;
+		packet->payload_info.packet_type = FIELD_GET(MCHP_OTPC_HR_PACKET_TYPE, word);
+
+		if (packet->payload_info.packet_type == PACKET_TYPE_REGULAR)
+			ret = mchp_otpc_read_packet_tag(otpc, packet->payload_info.packet_offset,
+							&packet->payload_info.packet_tag);
+
 		INIT_LIST_HEAD(&packet->list);
 		list_add_tail(&packet->list, &otpc->packets);
 
@@ -236,7 +295,7 @@ static struct nvmem_config mchp_nvmem_config = {
 	.type = NVMEM_TYPE_OTP,
 	.read_only = true,
 	.word_size = 4,
-	.stride = 4,
+	.stride = 1,
 	.reg_read = mchp_otpc_read,
 };
 
@@ -244,8 +303,9 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 {
 	struct nvmem_device *nvmem;
 	struct mchp_otpc *otpc;
-	u32 size;
+	u32 size, tmp;
 	int ret;
+	bool emul_enable;
 
 	otpc = devm_kzalloc(&pdev->dev, sizeof(*otpc), GFP_KERNEL);
 	if (!otpc)
@@ -256,10 +316,22 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 		return PTR_ERR(otpc->base);
 
 	otpc->dev = &pdev->dev;
+
+	tmp = readl_relaxed(otpc->base + MCHP_OTPC_MR);
+	emul_enable = tmp & MCHP_OTPC_MR_EMUL;
+	if (emul_enable)
+		dev_info(otpc->dev, "Emulation mode enabled\n");
+
 	ret = mchp_otpc_init_packets_list(otpc, &size);
 	if (ret)
 		return ret;
 
+	if (size == 0) {
+		dev_err(otpc->dev, "Cannot access OTP memory !\n");
+		if (!emul_enable)
+			dev_err(otpc->dev, "Boot packet not configured & Emulation mode not enabled !\n");
+	}
+
 	mchp_nvmem_config.dev = otpc->dev;
 	mchp_nvmem_config.add_legacy_fixed_of_cells = true;
 	mchp_nvmem_config.size = size;
-- 
2.34.1



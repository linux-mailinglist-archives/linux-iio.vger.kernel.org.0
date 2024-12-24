Return-Path: <linux-iio+bounces-13775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286229FBB71
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 10:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B41818849BF
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16A4196DB1;
	Tue, 24 Dec 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ObqbusBW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-m127172.xmail.ntesmail.com (mail-m127172.xmail.ntesmail.com [115.236.127.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C2117C220;
	Tue, 24 Dec 2024 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033564; cv=none; b=rxuaZsIReywHC/5F5q0OWs6pHpbp8Kh+3WLqJfYPyryUMTJuIZp2tCglrwEc6kDVNvliaVxtUgzA7KR1ZK3+WEJeufK72h0oc+BR3MCmYyBAuJxc0NNSzNLVRZ93J6oJW0urlq3b0Zvbpa6Z/T5LMwlxZvFtnWe+Xnwksq1bIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033564; c=relaxed/simple;
	bh=EkfSz/MCw1gMXEJ2136x207U3jPqgzUuAPeQpZOC8LI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P6NS5MpvJcKc5sNigXj5dSVuFO35QKuFwpRdwIrAW0nXrPAT/4aN0j1h89NrnutdHO+87NyNpWzmcSVOsPMk1DCXgqpPbfWOoDNRK+akS3F5g2WyLi63R+tCpgye5hgaF2GYU1AsdaG9d75smltiUh2G1kpXdC1fK63q/IVyvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ObqbusBW; arc=none smtp.client-ip=115.236.127.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aa905c1;
	Tue, 24 Dec 2024 17:40:44 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-iio@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add rockchip,rk3562-saradc string
Date: Tue, 24 Dec 2024 17:40:41 +0800
Message-Id: <20241224094042.3816483-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhLHlZISB9MSB5NGRkYTxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93f80a49e903afkunm6aa905c1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M0k6GAw6CDIXNko*FjgKMUws
	FwwwCzpVSlVKTEhOS0hISU9OT0pCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS01INwY+
DKIM-Signature:a=rsa-sha256;
	b=ObqbusBWSfS4UPK+E8i5hBIhgv393B0V4z8GuB/oANfdyfZpUr0wjivlwSlGVSz9Fr9BPYJMygj/1/ylUgQ9wSrXnggATA/qpkkM7ky4XX44QBoZIzs4bvo6dHDySfDz5iJ2TAmKkqu/h80NoY1ZPhTHkfC8kcqFm7XzSxM9rqQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=YQ0B+UF6z6qRHlvIZAjak6rQj1AlbRw5Fkx/l4QLEYs=;
	h=date:mime-version:subject:message-id:from;

Add rockchip,rk3562-saradc compatible string.
The saradc on rk3562 is v2 controller, with 10bit width which is different
with rk3588.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index fd93ed3991e0..da8bc6f50a32 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -16,9 +16,11 @@ properties:
       - const: rockchip,rk3066-tsadc
       - const: rockchip,rk3399-saradc
       - const: rockchip,rk3588-saradc
+      - const: rockchip,rk3562-saradc
       - items:
           - const: rockchip,rk3576-saradc
           - const: rockchip,rk3588-saradc
+          - const: rockchip,rk3562-saradc
       - items:
           - enum:
               - rockchip,px30-saradc
-- 
2.25.1



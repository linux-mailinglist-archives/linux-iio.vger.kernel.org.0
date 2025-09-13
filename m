Return-Path: <linux-iio+bounces-24066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20534B561DF
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3942F3AACB2
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7E2F360E;
	Sat, 13 Sep 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="RnaQfB7K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BF2F28EB;
	Sat, 13 Sep 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778014; cv=none; b=LELIFzdVbOpc4yVCLru2k6TM2pXq/F7aRd5CJUoonobMzekl/I6Gw5O3plB9gfyEqU/Zz6vtMaZQQl9E5im5G7p5SXF7j1acIEYfnD/rsj04OT50PwZ0JEHXrE0vFOzhPvGrs28VqgSa3Qtb5QYseN1dhUs8Q3s0HPj9CRvoee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778014; c=relaxed/simple;
	bh=8H7S7SgW+0FXgD2aRmtUEQVvdaydg9AkOYubDxSsbq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPO8StQw+3eu1LX5iIQlpyEScem1Jh6DRH0h+QUiqm70fkTV4/dhw+smrYCqNv8YVf5uyk7tKFCcYMkyM38r0qqOLS4KTWA0OMHaVzrbEv2MRYaeb1jT1vMCGPTISzrAEtRIQW0/3LQwTD5A83VAQiYwd7bYQH8RNsksHUJzLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=RnaQfB7K; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 9023B173BE9;
	Sat, 13 Sep 2025 18:40:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjtII/gmJYh28rgrlvVUalNP2FHFV2VvBOZDCSeHYTQ=;
	b=RnaQfB7KegahFMRXWyCGxlwLeSR3DG0m3bWpxrwGoA4QHlHxFBHEg3D0HZjwD5MqY/7YIY
	rjbIH9U/J8OhGaQ4KNajmTaPahjrP4Ayu1CbmwJlRjToZHK0IijZKeujN/+IQMp0Azbuyg
	tsT8HZBhxlDQpehzpUah+pbvLrazt6KRNkW7A74OFc51tgYKlBw/Y3sWWKcovBEE+4iNJO
	6gJOHbXHP3aHvH1al3aY0QBU7WUrT5XoYgsHcwxTnRzFByMlC/yCEBktrnIwg0Iw9KmaRs
	tcxgz1N1ncS0uJfEqZ1ohaDQveYj/G7iRviPcCYiE0JsTba3/Hg1UvrGqGK9zw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:22 +0300
Subject: [PATCH v3 01/18] dt-bindings: iio: accel: bosch,bma220 cleanup
 typo
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-1-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=8H7S7SgW+0FXgD2aRmtUEQVvdaydg9AkOYubDxSsbq4=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBR4A98FQVZerf1AuWYf0F6SYhQ9y9m76Z79
 faDx2kSLTuJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUQAKCRDPJpmZhE5/
 MG19EACTXR+Tw6oAZ0A7vQz7crHwt9ylpLHZ1VeZt/BxWAwPKCJrUEVmKYfNQKTe4VyCmLcdVwd
 +sU43XCMVKPV7DJ+xG4c2xrBfe0yYkZNM/E9cXTAjRn4qPHszcCdnRcmltzMIq6p31HVHbG0e5w
 1glSmBv0mFkpFnIcnP9tKo78id58lRcDYRi9MB6yADuXIel0EviuNZ2gcddXqPJlJOgEEdbtAxC
 YkaUhmfd2HNqP6VtwfQevyl8NarKnEoUzZxFljkcgSId6cy7Gu3HrO1bdmqc5JzG0pjjjuge8X9
 tmXsUDZzcMdhgwGb7bLVk8QmMZZskEREaVbONzT+31rLyD1tOUt14YZ5I2RMu9Ax4OHy8DWeUpM
 Yv/hHeScM2LRmuNTyzsv6UN409q2h5qWYzGj8mBeZzidhm4M7vaPHN+VXHt4iwgFWDEmAjhOu00
 Kz4981Opty7LapGiTXp427ZJ5woq357MRxCgCcmKG419J4WZMFYvQl8kfAKOmJ9MYVQZx94Wisx
 HzOvTV0gvlRfrqHrxSyhWnKKcs8fRd496p8sH94cqLHF+nDwWQW+hnbMwle36C9sZ+4MNHxijGV
 PGIJf4OYLCnfcW93axUm3aRwHl805xbSqxs+Mf8/619QNLEtmsbzwDEYN7Yq2eUULriTBuvU0pp
 d6ygvEM0Kwwx4Kw==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Cleanup typo present in the title.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
ChangeLog:
- split out from a bigger patch file
---
 Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
index ec643de031a34190af1bc2bffee7412ee2d3b902..da047258aca3d84e8b2cbe92a9c98309236fe7ae 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/accel/bosch,bma220.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bosch BMA220 Trixial Acceleration Sensor
+title: Bosch BMA220 Triaxial Acceleration Sensor
 
 maintainers:
   - Jonathan Cameron <Jonathan.Cameron@huawei.com>

-- 
2.49.1



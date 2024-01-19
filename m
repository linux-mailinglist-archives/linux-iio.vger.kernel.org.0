Return-Path: <linux-iio+bounces-1760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D133B832C9D
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 17:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F6F281D66
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CA854BFF;
	Fri, 19 Jan 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLx3N07M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5B54BE8;
	Fri, 19 Jan 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680069; cv=none; b=c0wYa3W6vx/tlY8UKnpc49dwNfZ7OeeKw+1Q8VEd60SDq3klu5jOp4vTZ42tcIRvOTYEJKqiA0FBUNQcZOWcFTHBQJ4cPcLwW+o35tB5yWObryYcXZgxGPFg8pmsQW2JDbsy2+oOqLjSFRsZU6FcTt0ThkUYj/gTXww63WjhMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680069; c=relaxed/simple;
	bh=cRBsVA/gjcOt9pjoEuJIhQ39NaZaSPebkpAvtLwDKu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RuTfzuEghFo0cO2oP5bFtEYiEDeu4WZj7xubspR2XeyGj+zfefes5ojeD0mGXG+9+c6wIfIYkmrNjdHp727k6fuwX7luyFNpZKE1c+xpIJcQ1ZXNstfK7MNG8c8akbi3XJZ0IaFS1l/2RdJk5qLLSbMPN81ZR91Wcxne408QQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLx3N07M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 608AEC433C7;
	Fri, 19 Jan 2024 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705680069;
	bh=cRBsVA/gjcOt9pjoEuJIhQ39NaZaSPebkpAvtLwDKu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sLx3N07MtITVXcK1m1UIJgDe44vcVm4t0yOu/4krkfPDJqYoELVyZomStInRIxa84
	 1RjZ4KPkoO2dN3tErC5C11ZErvzVWDI/2/ukb7SccFTHMSQbfCZAokO7wY2NS0u16B
	 1BLDQ96YoIR+Qe5pxEjwNwSqLmPdtmEm9NNRUxvdx33Kx4Nagr3C9CIZvQ0rX9FIgW
	 EbuyE+qk4kbWEnkf/pRE3hAk2UZIcMFEbiD+4hD2FK35KVMpe8bcRbVGBxZd0/6+1C
	 LFjMQF/nW7XKXgWuKMaNDHdBcPnyJopp8XRmhCz+/BUW7I1hWahNWDvdSGt62H60Ho
	 ForBvRQ4asf/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454CCC47DD6;
	Fri, 19 Jan 2024 16:01:09 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Jan 2024 17:00:47 +0100
Subject: [PATCH v6 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-iio-backend-v6-1-189536c35a05@analog.com>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
In-Reply-To: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705680065; l=1193;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=u0BDfBpNIPqTnjAdSKSUmF2FUWY8hltyVdK2adeadi0=;
 b=C8ZXHJRK4mxXyrcT9biL0tbjXlOsedW5wPNxrWe8PHwMNx7DFMNi3KvMs9ktjTFJ+3qGQAwJv
 VoDmEvrhTqzBJBpM3D+8dx8QRNYd6IGOwIpTWEH66Cc8xtMqPH7QXPK
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

The ad9467 will make use of the new IIO backend framework which is a
provider - consumer interface where IIO backends provide services to
consumers. As such, and being this device a consumer,  add the new
generic io-backend property to the bindings.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 7aa748d6b7a0..eecd5fbab695 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -44,6 +44,9 @@ properties:
       Pin that controls the powerdown mode of the device.
     maxItems: 1
 
+  io-backends:
+    maxItems: 1
+
   reset-gpios:
     description:
       Reset pin for the device.
@@ -68,6 +71,7 @@ examples:
             reg = <0>;
             clocks = <&adc_clk>;
             clock-names = "adc-clk";
+            io-backends = <&iio_backend>;
         };
     };
 ...

-- 
2.43.0



Return-Path: <linux-iio+bounces-3254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7186E715
	for <lists+linux-iio@lfdr.de>; Fri,  1 Mar 2024 18:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FEB5B2C19B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Mar 2024 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99EF6FC3;
	Fri,  1 Mar 2024 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4QQg76l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C9FBF5;
	Fri,  1 Mar 2024 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313293; cv=none; b=CSSfaE3WmWf7BnoITo2qSyjPRewjdQysrXvqVd+sNK4kUzZms3lHaTw0ptGKFQuNJ9efBgBD5gQwJe3y45ZLUhNDpJRI9peARS9kzpxFJdWxB4KrPZaQXuU00K+th0EBwq1HyfcaXk3wKyNHuAWHS/fUN/3afVoaYNKOquQHs0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313293; c=relaxed/simple;
	bh=iU4ye3YD5mJYIMLDbIQUPxRF5RMbXybTMwbi1mW2Z9g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eL8axTyJbPJSRm7iC4C42JaqWNNxGhqyv5UlnWOJ+Yih+Kk9ZMLVcgWax6WfbCHN1MX/wtxDc6ufxgu5BzbGJWYiIVfFAEN32ivCz9DAXclecCg9pCxf0e4yhXl4YRxItx4tjhE81MCxtNmRwMEU1GBZ3zCejBIIg4kUC7Aqprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4QQg76l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CD69C433F1;
	Fri,  1 Mar 2024 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709313293;
	bh=iU4ye3YD5mJYIMLDbIQUPxRF5RMbXybTMwbi1mW2Z9g=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=n4QQg76l4qRiQQdPJc/NbO2/K8v5VUhe2GYcHZvsfdA7H/PMUrqE0z2ywIhMKA/H/
	 sf8UXFHGDsIsXORvqMz8miMeeNI5xGIQ7EKD1K/RiMB38YNeg/AMF0Abn1Nag9SnTK
	 nwAa30q1V+l/DHJL/hVErfBFRwcrqv6cwPDGgGiEg8NdJQBuGWiHCYt0yvJxd+Lxu9
	 KR40c2Z2R8kdtHeyew/UD6fS1TulpAwiXOvkKsSir6b+WFq3V2gEvw1uxnNdZHNnm9
	 lfAPxTvNrrqmmxS4KbnnwFj9wYGv4n0KBBsUz2xStYYex4S1K3qPOhrzdUrJyCENtC
	 4ZaPac+vp44Eg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5483FC5475B;
	Fri,  1 Mar 2024 17:14:53 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v3 0/3] iio: temperature: ltc2983: small improvements
Date: Fri, 01 Mar 2024 18:14:49 +0100
Message-Id: <20240301-ltc2983-misc-improv-v3-0-c09516ac0efc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAkN4mUC/x3MQQqAIBBA0avErBvIMUi7SrQom2ogLTQiiO6et
 HyL/x9IHIUTtMUDkS9JsocMXRbg1iEsjDJlA1VUV0QNbqcjazR6SQ7FH3G/cLKuHrRRdlQz5PK
 IPMv9X7v+fT+86InMZQAAAA==
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709313291; l=885;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=iU4ye3YD5mJYIMLDbIQUPxRF5RMbXybTMwbi1mW2Z9g=;
 b=SxIZfLh6ggzU9sPVChDLFPaB1wbTNwRMvddiUoVX1lYExajJS9DDvZjFioPAWgixGO2xiCaex
 XI7r7G0nsxTA5cNaHKBVQMxCu5CN0DkLjyRo3OEnzbBr5/2XJZ7VrPc
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

Hi Jonathan,

The quick v3 is only to fix the error in the bindings patch...

v1:
 * https://lore.kernel.org/all/20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com/

v2:
 * https://lore.kernel.org/all/20240229-ltc2983-misc-improv-v2-0-cc6f03da2529@analog.com/

v3:
 - Patch 2
   * Added vdd-supply to the dts example;

---
Nuno Sa (3):
      iio: temperature: ltc2983: convert to dev_err_probe()
      dt-bindings: iio: temperature: ltc2983: document power supply
      iio: temperature: ltc2983: support vdd regulator

 .../bindings/iio/temperature/adi,ltc2983.yaml      |   4 +
 drivers/iio/temperature/ltc2983.c                  | 267 ++++++++++-----------
 2 files changed, 131 insertions(+), 140 deletions(-)
---
base-commit: 74744b27ba8cb8c265263aa0ff0693350a8cbc19
change-id: 20240227-ltc2983-misc-improv-d9c4a3819b1f
--

Thanks!
- Nuno Sá



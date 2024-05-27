Return-Path: <linux-iio+bounces-5340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B0F8D05E2
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5591C21840
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00815EFBD;
	Mon, 27 May 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6Ggu6jK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49715A872;
	Mon, 27 May 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822730; cv=none; b=plchVXjwkn3Ye+yzNaUSV7njkzvoqUBSpRIQzSshrp200CbybvQPJi3dnkbCmmXf+8O1FCTU3fZklFuTsxxJiS7Zx25W5+8kwW7NyYtm4g3ZS0xIuW82k0sm1r5dDs6XORkoU7Q8NAOpTbfMdrXrmzoq6ytp+qy5icaxACL6gro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822730; c=relaxed/simple;
	bh=3TIcAQi2/9dfC8qhlCEi0dXTPr4blkbXwfz9/iRnzJE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sYP7yOkVUZ6Vk34eW8KZwUkc22vmxDTbQbt+nu14b8s+PhJ+kkneqi/j2eYRx6XsPdkDsEw4adQi6TyVr9wpvHfRgiL7PBe83QQ2hFjU5NUeoJ0eh5osnPEcNA5tuUZLoYaer4eP+BRRmOrnCTrSLrS0hPjdWkJrb8WF1UH0n80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6Ggu6jK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36954C2BBFC;
	Mon, 27 May 2024 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716822730;
	bh=3TIcAQi2/9dfC8qhlCEi0dXTPr4blkbXwfz9/iRnzJE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=a6Ggu6jK3bCqSnwAxBUWX2TERM+853A3ZUyTtRTLhkvz6NZk8xhjOZs2fZp/hTtqT
	 96FKr7G1LyYK7VdLQxPo5MmiX7MEIxxJpT1/314w8U5F6pt2dGpA/fHtCaC4Kzz94V
	 WjICiVVhhOkZwHoZd5cXLjl64lGSNP3WD+1fSiFkuhuO7j6CrT8L8ausXuLRCzBFn8
	 l0OrM6MqBiL5oiYgWqRnobnPkXagi9Ur48IvgdkhSykBeFdpciuzv4gNHUPaArQWJR
	 gga8SO/06n2uvaT8czDJiTbTg/gcOqP+yWxcGCxBQZQP1gVCdv5SgiRohh+Uw/qDfF
	 0eJ+JRs5noCNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9B6C25B74;
	Mon, 27 May 2024 15:12:10 +0000 (UTC)
From: Arthur Becker via B4 Relay <devnull+arthur.becker.sentec.com@kernel.org>
Subject: [PATCH v3 0/2] Add driver for Vishay VEML6040
Date: Mon, 27 May 2024 17:12:07 +0200
Message-Id: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMiiVGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNz3bLU3BwzAxMDXQNjQ5O0ZANTE2NjcyWg8oKi1LTMCrBR0bG1tQA
 NU0qIWgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Arthur Becker <arthur.becker@sentec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716822728; l=935;
 i=arthur.becker@sentec.com; s=20240521; h=from:subject:message-id;
 bh=3TIcAQi2/9dfC8qhlCEi0dXTPr4blkbXwfz9/iRnzJE=;
 b=f2u7rFyobvpBdch0ALMVecwwaYCyHKuTeMnZww3hvZMllZIRMVdwEBwhmzEEVqSJxSExX9Z1d
 myA6vZXuI8oBEcQPnNb3R8Vx5cVh/so7HQc6BYQLIIJlnjIxl0DXQD8
X-Developer-Key: i=arthur.becker@sentec.com; a=ed25519;
 pk=1GLsDBF6GZKt9oNFsvdnAB6sHyKKrSISlwM3AyWbx/k=
X-Endpoint-Received: by B4 Relay for arthur.becker@sentec.com/20240521 with
 auth_id=163
X-Original-From: Arthur Becker <arthur.becker@sentec.com>
Reply-To: arthur.becker@sentec.com

Thank you Jonathan, Krzysztof and Conor for your comments on my previous
submission attempts. I hope that I addressed all points!

Changes since v2:
- formatting, renaming of variables
- power supply added in dt-binding file and turned on in driver
(- using b4!)

Signed-off-by: Arthur Becker <arthur.becker@sentec.com>
---
Arthur Becker (2):
      iio: light: driver for Vishay VEML6040
      dt-bindings: iio: light: add VEML6040 RGBW-LS bindings

 .../bindings/iio/light/vishay,veml6040.yaml        |  44 ++++
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/veml6040.c                       | 283 +++++++++++++++++++++
 4 files changed, 339 insertions(+)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240527-veml6040-0314fc054337

Best regards,
-- 
Arthur Becker <arthur.becker@sentec.com>




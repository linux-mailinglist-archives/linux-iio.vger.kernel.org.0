Return-Path: <linux-iio+bounces-10751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADD09A4A22
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 01:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAA428284F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 23:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82734191F66;
	Fri, 18 Oct 2024 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="WO09xFSL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtnUEmnd"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B8E170A0C;
	Fri, 18 Oct 2024 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294714; cv=none; b=t44xYp9OcGR/wL0RoHoJOWawYDoYtoUCKM/+9Cu8wpjWLZOCagFXqBEYTVbqucBVP+iPWko7usi0QNnavrvj+0gebB1Mx2ml0f4Au98pOlwgJ5YKSXijYbY2IKzSPrT8eL2OwoiCUImFYflQuf82lHOzWZyQAmFgyViLT0fIJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294714; c=relaxed/simple;
	bh=8Mzxjvr6pqmET2+vuwfGzxgc5CDTOOOVPkje8V5HPr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5NhBcB3YS5S4g3BBIISWFPtuzo/FZaZC1zKbP1ymaAzS2GMGojb9eoKFINsQtaDVka3zBmy84L+UFUiIwYpatE2hxcQbRybZT2zK+8pQ6ipNhzqRDlCQg7MpReAHGd1g7+hstuAl9TmMX5zozQUxbxkU8ANImSuaYBSLEczeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=WO09xFSL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtnUEmnd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 161E71380256;
	Fri, 18 Oct 2024 19:38:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 18 Oct 2024 19:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729294711; x=
	1729381111; bh=h0xnwWYrsLs+HCnDx67w6s2AQcXWhkdn4kqNreYvgwQ=; b=W
	O09xFSLpebu3frRG41QSf+D3O9i7AqLmONVsdSBJFYXVzRow1XJAAr96tMzqazfF
	CIBmz8uaWy0PaXl4KF1QaXodM6sSnmuvn2bYGIMLPIUw+IsgfRLhw3wxLYgvgydT
	hEfasEVaAMS0EqUXA3MwnKPuZ3I5f9Cipqvbuy9Kb5vNy6nWrL0Aw9GPUxz0sLGH
	3qhFENk2+OWLGmvxTkvBNn77M8xUqfaSPAxBN4RLybFxPpTSQy3T+mQNljUBoXJ5
	quXdfq1BD1aFsb0mtf2JySV5lcqg2f2/lyM5swtcCoqUO6A07e6QLIPsIvuO5KQs
	Ic3QiF3SMSotnbqapdAsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729294711; x=
	1729381111; bh=h0xnwWYrsLs+HCnDx67w6s2AQcXWhkdn4kqNreYvgwQ=; b=F
	tnUEmndnNUcAtAFBskfbmJSE+P1QGwupt9SLndDdaXyy7e+37vaL/NWOB4/njzJq
	QO6rgTmLju6fPNgP4OtexNQdKY6zeqKbR4Kw0SOQl5CQF1GYFuaHLlwc/9V5oP95
	StLiiavGETpN4OTU9KoAYGDA0CoId+2ed7zGg8hCCT7kjD80/P6M9l6eOUUrb6qM
	Kr7Qp8g18U7FIgaeN4PTe/8GSkYLtX3qSfAvA3yoSiQBcXld98Ut0BDNNLM/FJCB
	Ax8JHWXHnE9OeIy7PFTwJLEzz5LlmHS1ZcxEEuMu6SeHhTGE0PRdlKNJIG4gP7l4
	vXcfB0c7x+MJBWHBp3iMg==
X-ME-Sender: <xms:dvESZyqNlb_HiqeZ24Pq77hAwbaEE__1uLgkjw12pSeZfvRwIRLxvA>
    <xme:dvESZwrzLsZfkIFFZM43PAjzulCMQwAQAnKT6I9d8ElM-HDQMQwxUIlQBFsZv7aik
    Wha1LVzN0qxP_sOrw>
X-ME-Received: <xmr:dvESZ3PP8EAg4hoWBDJ43FaYSIhfpuzCixHJES7e-UhqYfdKQ9r4E6EkH7782OamOfqqETB9wE2VUyVzOLhsWURP2BnZ31zToNahR59eqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeiffdtvdfgtddvieetffduhfejtdef
    teelkefgteekgeegffduiefhudeiveejkeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtgho
    mhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hlrghniigrnhhordgrlhgvgiesghhmrghilhdrtghomhdprhgtphhtthhopehjihgtvdef
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghrshesmhgvthgrfhhoohdruggvpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdo
    ughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dvESZx4S0T2873FI9ImJeBzTtsT2tOPQUfdcVsl-1ckRzeGk7FoBWA>
    <xmx:dvESZx5vNxy1HN81a84Zg0aM0fcXI4hJPZWBCa-dlA1wwv-1LmrAFw>
    <xmx:dvESZxjg_cWZFxsrvVpNgkh6GlEzNts9VzMcPDoNTCu-oSYUjGKJCA>
    <xmx:dvESZ76LKz2AcIx2USDXs8ZGJyMmQcesFSVcJZ2keF3OOT98wQ7E7A>
    <xmx:d_ESZ5z36Rc-0TS-GJJpOr4Hmnaso4264Kld8vWsQmdCeNKWUiKpHSuZ>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 19:38:29 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH v2 1/6] iio: imu: bmi270: Use INFO_SAMP_FREQ instead of INFO_FREQUENCY
Date: Fri, 18 Oct 2024 16:36:07 -0700
Message-ID: <20241018233723.28757-2-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018233723.28757-1-justin@justinweiss.com>
References: <20241018233723.28757-1-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use IIO_CHAN_INFO_SAMP_FREQ instead of IIO_CHAN_INFO_FREQUENCY
to match the BMI160 / BMI323 drivers.

Fixes: 3ea51548d6b2 ("iio: imu: Add i2c driver for bmi270 imu")
Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index aeda7c4228df..87036f352698 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -122,7 +122,7 @@ static const struct iio_info bmi270_info = {
 	.channel2 = IIO_MOD_##_axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
-		BIT(IIO_CHAN_INFO_FREQUENCY),			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
 }
 
 #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
@@ -131,7 +131,7 @@ static const struct iio_info bmi270_info = {
 	.channel2 = IIO_MOD_##_axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
-		BIT(IIO_CHAN_INFO_FREQUENCY),			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
 }
 
 static const struct iio_chan_spec bmi270_channels[] = {
-- 
2.47.0



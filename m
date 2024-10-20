Return-Path: <linux-iio+bounces-10829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE069A5721
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 00:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A94A1C20C81
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 22:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0AF198E93;
	Sun, 20 Oct 2024 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="JWF91zCd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lDr8om9h"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701CF18C936;
	Sun, 20 Oct 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729461682; cv=none; b=rfneUY6AtVqbYcPLpwOHjTHPvZ3kc1+B8Ts416PYQ22qc/YiiuXzYUH9tlGh9OOnpHGPbrnTYTy3pZjmxkZ8ERbIPbxSuRG/BGJk2jAf6H3ZnbtRVI9bZHS4ZH/KbkfjL6XmXG9QK4ataUGjYXt43r6yEBLhhhPBsx0HmLW4v0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729461682; c=relaxed/simple;
	bh=qdw5MFMRgYhe+aVYPJBeXeKc1wATpB/PgzF8oG7E8mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n31JJHDNyeyYclSnkoLCmy12/9BfkifXSqYEKaJ5G2pzc6qm/gy6Sl9dwr6goK/jjZQqDUsV85w4+3uGoHJDLzhDZMNwXMep6Jbw0KFUKmCvu0DsCa5qC+oLXERB9ueAoH5dLNe97ZSwexG4CtgPZhXkh0lJAV34783nphBf7b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=JWF91zCd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lDr8om9h; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 307E12540090;
	Sun, 20 Oct 2024 18:01:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 20 Oct 2024 18:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729461679; x=
	1729548079; bh=Mj+psUKkmik1WyC08oA/zlwOnP61AyJE1/Yu7zehAGg=; b=J
	WF91zCdA/933hY/YBMwjqE3371Ux+NYk57RTVbE35bT3KqmZIe4hGycP5s9q4ykw
	LINzBR/RtZNOwJcg5QdAWcsdWRKunA/TG5gtTvDlzsIoB0YFfcv58H33659sdMN/
	9VKadxnLiRR1UKRjUcPSaY+gN+dDg+YoeV4tJ4vb8s3Su6MCrsN9LURkOEj3ri48
	6i8Hg7ofNC5ftLA/Pyr9u2idOQ8MdECkCWK/9EqzDoJWADtrv+84SKD+KoiLcnSw
	AqG3Wke7IUTcWxGQLGskDpqCBxmf+v2XSAj+90VgxpGuNf8QzuX7M1pH1Ta9R4FY
	8tl1REZ53BIPGnODH7o0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729461679; x=
	1729548079; bh=Mj+psUKkmik1WyC08oA/zlwOnP61AyJE1/Yu7zehAGg=; b=l
	Dr8om9hPMfxIzlFu8Z25t6dgAqca16aeFyL9znQaGOdTWLrWfK9FNH22PdxUO5T1
	0kuk1cn8EoGfOjFmfqGmBL9PF6IQLt+AZ8q8IaBHG+AbmIQoavJje+bFdxZB6whT
	3Ca/ilJkOVqOkQQfngaDhfhaKfF1a1H92KDH3yoH2fl9cAud4xcsHgCqkxZrB/yO
	ViA1ZKgybXGynL5Yufv+3JVRVZVWsepoO4lPxXgV42sjYJhsvt+6ekXdTbifbmz3
	hpmjxaJI2fkFKIO4L167THA53U/K5N+aQ0UqtNBiTxW/9HjzUmWHkjlrFPHyh0ql
	+/W5dt6WPDn5/lH9UCSew==
X-ME-Sender: <xms:rn0VZwwqEl-40FXcjnsOWzWG4Fnd_Vk3bxnJyKKSxXhrrXHqrs_5KA>
    <xme:rn0VZ0TLiD-zW688a_kcI4AYz7cDzXwBznUg_E2plmn6pORU6SHMDz_08NI1nv9q1
    cGFTg8Ls6ZHXz9Q3w>
X-ME-Received: <xmr:rn0VZyX87UXE5HrGeruDyP_jzNJ52fGF44IGv2mlPusDWBcXI1yKWv9kPQkYStyzky7M47D6ff3D2BWGwiRX1lrXIeIGz1Rw-EW5p00ZWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedgtdeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:rn0VZ-gF3WPphOQKDIfbF1V0TWnFzfoZepQ0SyeDrqBRJxXoPSxtlA>
    <xmx:rn0VZyC4jfZ9weZd-6cuf4dLJn6NXRGlI7mcTICVteLs9r6ydEgS6A>
    <xmx:rn0VZ_LBKkzjdwZb0r-bePGuypS9meN-v2eyV3CX5PwEj_mfLTzj6g>
    <xmx:rn0VZ5CRKfLC-2UrZb95xnl_gVxxmlCFnUlWtPY0eZZ5u9Lq9kp-fw>
    <xmx:r30VZ-4VnWvS6xOJVPzYIGlX-WWWW8fMXSJv2-Jok_nrWf_fsvi6xWmw>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 18:01:17 -0400 (EDT)
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
Subject: [PATCH v3 1/6] iio: imu: bmi270: Remove unused FREQUENCY / SCALE attributes
Date: Sun, 20 Oct 2024 15:00:05 -0700
Message-ID: <20241020220011.212395-2-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241020220011.212395-1-justin@justinweiss.com>
References: <20241020220011.212395-1-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These attributes are not currently wired up, and will always return
EINVAL.

Fixes: 3ea51548d6b2 ("iio: imu: Add i2c driver for bmi270 imu")
Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index aeda7c4228df..e598c642178f 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -121,8 +121,6 @@ static const struct iio_info bmi270_info = {
 	.modified = 1,						\
 	.channel2 = IIO_MOD_##_axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
-		BIT(IIO_CHAN_INFO_FREQUENCY),			\
 }
 
 #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
@@ -130,8 +128,6 @@ static const struct iio_info bmi270_info = {
 	.modified = 1,						\
 	.channel2 = IIO_MOD_##_axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
-		BIT(IIO_CHAN_INFO_FREQUENCY),			\
 }
 
 static const struct iio_chan_spec bmi270_channels[] = {
-- 
2.47.0



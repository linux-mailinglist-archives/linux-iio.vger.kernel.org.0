Return-Path: <linux-iio+bounces-4005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5908895B16
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F577288048
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF415AAB4;
	Tue,  2 Apr 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX1vEauQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942A175A1;
	Tue,  2 Apr 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080234; cv=none; b=Vknu90rX6q03FqLi4Or19946FgOZQOVmZfhCt0tqPc9+vc+KualZ6ilhBIPO07V3L54Wy5j90nwezmyHYfskdztbrras92iDetyEUa/klj5WCBcv+7vc9ley7SM3thQbNVrp31CVGxB+I5QN7MvfiLG1jq9TH7ry6A88FFyCdDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080234; c=relaxed/simple;
	bh=sZv0jlhFBFOdyS+sZClYNmbL18QFPsyfUOpriRYVglU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGB8ekAk7d+PvBg+DOxBxqENkUuRNTerT7ZuDPD4XAfHcFO27cuGref9TfGWE6VcHPuf1OiSmr6+eeciqh2eBTHEd1aBGlpckXZRYVwCdy2GS6NzGRuv54rq3ib9zxDB89bLKDeg7V2gFN8vLl8wytCqXX8ak4BYWIA+bKXrhyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX1vEauQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82340C433C7;
	Tue,  2 Apr 2024 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712080234;
	bh=sZv0jlhFBFOdyS+sZClYNmbL18QFPsyfUOpriRYVglU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BX1vEauQ4uo7+aH7/pSumiAjSQrcTvjP/XGtDLpOftSYvszVM0pyanntIHt+itXFA
	 8dCnCoEvsyX3phNkuJQWRiJYFmJckAlWK2gJDJ2rtgi+iTORFTeuvt18YX0hiumKiz
	 xUD0q1Z2cE554fckfLFQ7HXMMOkRJRS42/A/8xXEM5da+uXTiac5g0eWzc/aFbsZvS
	 2R1qOSkQJUwW27RTqN2D7brRFHhYZYJqFFXOOAwjd8zkmSDvO4QNX9vEU/PH1TbjsR
	 pMoO46qIT5PApQ52eSV30HdANxGvJJLJGM87dqiOYoOehotH8BVXUuYtixsgpKydP8
	 PUbx2mULM8qjg==
From: William Breathitt Gray <wbg@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	syednwaris@gmail.com
Subject: Re: [PATCH] counter: ti-ecap-capture: Utilize COUNTER_COMP_FREQUENCY macro
Date: Tue,  2 Apr 2024 13:50:18 -0400
Message-ID: <171208011376.11528.13757651083685639137.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <ZfxhEKdSi1amfcJC@ishi>
References: <ZfxhEKdSi1amfcJC@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Mar 2024 12:32:16 -0400, William Breathitt Gray wrote:
> Reduce boilerplate by leveraging the COUNTER_COMP_FREQUENCY() macro to
> define the "frequency" extension.
> 
> 

Applied, thanks!

[1/1] counter: ti-ecap-capture: Utilize COUNTER_COMP_FREQUENCY macro
      commit: 916baadd293a4d11e08a7ca1e2968314451ade6c

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>


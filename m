Return-Path: <linux-iio+bounces-21947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE6DB10898
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5393AC102
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEF926C385;
	Thu, 24 Jul 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNScDwQR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CCF26B762;
	Thu, 24 Jul 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355235; cv=none; b=ssBE/wXB7/RKTUXBGocDfbKBZT1mqjpmpXxwoiM5c2d7xG92JQn5LPrEQjZSAKKRtbepf7tu3Z6fNOY5JqzyEJleZiPBENbIwAEUe0vF5IoDR+YTF8sHzo7mkhnn7wlkb+auDS8BSDrV16W78RwJeWTkZpKC43wQac+IvFWkSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355235; c=relaxed/simple;
	bh=WfaqMmoAiODt4F5x8vjxnsOpOuRR/rNKHYdd9asBlDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrX/zjBHQAj/1Hy772rkhAAJ/Cq+D1Jhp1GhEXulBGZbWpOrwgKoPu1Qa0DrUEOTz0xnuWiytRMNk5VjxmRiNEiBR/UM00qMBrx6feVWmfzCuaetxFvGd+YgTfcotT/F18fDPYcJZ8+7g5r+t14aK4/U37Lw2rwaHsnW0u0OhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNScDwQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B7EC4CEEF;
	Thu, 24 Jul 2025 11:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753355234;
	bh=WfaqMmoAiODt4F5x8vjxnsOpOuRR/rNKHYdd9asBlDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZNScDwQR9rOUTV0lvmy3FpmZTr27MyqBMrsDM0x8P95HkIORIZH2oLVPrP9e8PACp
	 VL8uKVcKi3EVVK/o3n9akN55adzOFlTa4wQySiTiQv6Wc01eziosD+fpfGi/Mj/Sr0
	 oYqq7LXSXtxAZylqtNzW8PQOiKT0dvv4Aq6LoK34DH8i9qRcO7qSRaf6jgZoq4p3dm
	 Z8f4EvQtpbecprqotI3p4i+ZXDJ1i+yUZSSpu6FPvumcw15oVmATBt/WoPTQanFlTB
	 +eTP+FtsK4tgTozN240+BcMi32Rk0doVQJP2t5+NEQOvW2FIEImXIT7TICwd7AS4Sr
	 vygUysiqQUv3g==
Date: Thu, 24 Jul 2025 12:07:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7173: prevent scan if too many setups
 requested
Message-ID: <20250724120706.222da8e5@jic23-huawei>
In-Reply-To: <aIDzAiQT0S0-ZcQo@smile.fi.intel.com>
References: <20250722-iio-adc-ad7173-fix-setup-use-limits-v2-1-8e96bdb72a9c@baylibre.com>
	<aIDzAiQT0S0-ZcQo@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 17:34:42 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jul 22, 2025 at 02:20:07PM -0500, David Lechner wrote:
> > Add a check to ad7173_update_scan_mode() to ensure that we didn't exceed
> > the maximum number of unique channel configurations.
> > 
> > In the AD7173 family of chips, there are some chips that have 16
> > CHANNELx registers but only 8 setups (combination of CONFIGx, FILTERx,
> > GAINx and OFFSETx registers). Since commit 92c247216918 ("iio: adc:
> > ad7173: fix num_slots"), it is possible to have more than 8 channels
> > enabled in a scan at the same time, so it is possible to get a bad
> > configuration when more than 8 channels are using unique configurations.
> > This happens because the algorithm to allocate the setup slots only
> > takes into account which slot has been least recently used and doesn't
> > know about the maximum number of slots available.
> > 
> > Since the algorithm to allocate the setup slots is quite complex, it is
> > simpler to check after the fact if the current state is valid or not.
> > So this patch adds a check in ad7173_update_scan_mode() after setting up
> > all of the configurations to make sure that the actual setup still
> > matches the requested setup for each enabled channel. If not, we prevent
> > the scan from being enabled and return an error.
> > 
> > The setup comparison in ad7173_setup_equal() is refactored to a separate
> > function since we need to call it in two places now.  
> 
> ...
> 
> > + * ad7173_setup_equal - Compare two channel setups  
> 
> Better naming is
> ad7173_is_setup_equal().
> 
Agree.  Tweaked with following and applied to the fixes-togreg-for-6.17
branch of iio.git + marked for stable.

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 131cd1cf8a23..683146e83ab2 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -200,7 +200,7 @@ struct ad7173_channel_config {
        /*
         * Following fields are used to compare equality. If you
         * make adaptations in it, you most likely also have to adapt
-        * ad7173_setup_equal(), too.
+        * ad7173_is_setup_equal(), too.
         */
        struct_group(config_props,
                bool bipolar;
@@ -562,7 +562,7 @@ static void ad7173_reset_usage_cnts(struct ad7173_state *st)
 }
 
 /**
- * ad7173_setup_equal - Compare two channel setups
+ * ad7173_is_setup_equal - Compare two channel setups
  * @cfg1: First channel configuration
  * @cfg2: Second channel configuration
  *
@@ -571,8 +571,8 @@ static void ad7173_reset_usage_cnts(struct ad7173_state *st)
  *
  * Returns: true if the setups are identical, false otherwise
  */
-static bool ad7173_setup_equal(const struct ad7173_channel_config *cfg1,
-                              const struct ad7173_channel_config *cfg2)
+static bool ad7173_is_setup_equal(const struct ad7173_channel_config *cfg1,
+                                 const struct ad7173_channel_config *cfg2)
 {
        /*
         * This is just to make sure that the comparison is adapted after
@@ -601,7 +601,7 @@ ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *c
        for (i = 0; i < st->num_channels; i++) {
                cfg_aux = &st->channels[i].cfg;
 
-               if (cfg_aux->live && ad7173_setup_equal(cfg, cfg_aux))
+               if (cfg_aux->live && ad7173_is_setup_equal(cfg, cfg_aux))
                        return cfg_aux;
        }
        return NULL;
@@ -1283,7 +1283,7 @@ static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
                         * have too many unique configurations requested for
                         * the available slots and at least one was overwritten.
                         */
-                       if (!ad7173_setup_equal(cfg1, cfg2)) {
+                       if (!ad7173_is_setup_equal(cfg1, cfg2)) {
                                /*
                                 * At this point, there isn't a way to tell
                                 * which setups are actually programmed in the




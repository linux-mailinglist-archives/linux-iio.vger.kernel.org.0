Return-Path: <linux-iio+bounces-8598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51BE956D61
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6209A285AAB
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71216BE23;
	Mon, 19 Aug 2024 14:33:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28925760;
	Mon, 19 Aug 2024 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078033; cv=none; b=PPmY6duE+dROgxh9cItf0lr2gMI+S6fx8dk5VHAelNZkSLt1BY/tlMOIaZA3pKmr/W8rKCVytdlCtmgLRTIl6eFthj9hTIBjtIhGnkud3HfsJZNkKHflqQITrhhp20fn4ldxIdpmnGu0SJr+wYlPaXTIeUd44Wzm9nUh5dD1kc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078033; c=relaxed/simple;
	bh=2EcRFcFZ24hxH7FI/vmbdXoJjqRfMTBJZTWq0UYw8O8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byyhz9nIF1g7PbTOEQlfcjGhe/BCD83MgG4GKgk6aVF0xDxKcaA3r0J683URVD44mHS+HcFneyEBUeJ/4wWE5O5KSMU1uN2ve7Yr+4OYNQnuWFWjGcbTOu5wyQGZKX6ovnwkowrigQ9sgbe6jubbvnNmdBb7oginGxNPZa7f0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0CBF339;
	Mon, 19 Aug 2024 07:34:16 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 528833F73B;
	Mon, 19 Aug 2024 07:33:48 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Michal Simek <michal.simek@amd.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	James Clark <james.clark@linaro.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Pavel Machek <pavel@ucw.cz>,
	Mike Leach <mike.leach@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 0/3] use device_for_each_child_node_scoped to access device child nodes
Date: Mon, 19 Aug 2024 15:33:34 +0100
Message-Id: <172407794569.198441.3395176443590632204.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808-device_child_node_access-v2-0-fc757cc76650@gmail.com>
References: <20240808-device_child_node_access-v2-0-fc757cc76650@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 08 Aug 2024 17:12:36 +0200, Javier Carrasco wrote:
> This series removes accesses to the device `fwnode` to iterate over its
> own child nodes. Using the `device_for_each_child_node` macro provides
> direct access to the device child nodes, and given that in all cases
> they are only required within the loop, the scoped variant of the macro
> can be used.
> 
> It has been stated in previous discussions [1] that `device_for_each_*`
> should be used to access device child nodes, removing the need to access
> its internal fwnode, and restricting `fwnode_for_each_*` to traversing
> subnodes when required.
> 
> [...]

Applied, to coresight next tree. Thanks!

[1/3] coresight: cti: use device_* to iterate over device child nodes
      https://git.kernel.org/coresight/c/daca644d0c9e0

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>


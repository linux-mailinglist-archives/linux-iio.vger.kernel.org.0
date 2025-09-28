Return-Path: <linux-iio+bounces-24530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A5DBA6F77
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 12:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655053B93D0
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0A2D594A;
	Sun, 28 Sep 2025 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws5lw7Cc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4519C560
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759057182; cv=none; b=m5G0xDFrjvH8ZCoAtUe2lSZUHVMIn8Mg2SnXvwqlk+hKXCOpxzCAuaN8iIqxLjMa7EPv1dpFm9UL6LbnZY6QrE00LP7+KlKJP48haPrHe5PYPrnCqsXbCPRqowsaAIRp9QHnSCLT0jrpJhFK/GWCxept8jGSUjsyKuv/UCew3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759057182; c=relaxed/simple;
	bh=KCUKwNYi0asIfDjq82o+hBhIZN4sIPx1woQH0TqLgwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqqqOiv2zv/E1rcuyCowO8QANWrqLS8r9bQ9/yAuieEmyLxBYL1rWOPFegBXL6YJjXOG+1QsLXCxyrTLxiar1gX24CDJMU+mdxki0YX7xLWK1mmkAMj7djTUCmYQ9aXlVDoeI2Y/Adlc8AV7U3sO4EnH099YfoLVlQF/7Ax1bQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws5lw7Cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2710AC4CEF0;
	Sun, 28 Sep 2025 10:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759057181;
	bh=KCUKwNYi0asIfDjq82o+hBhIZN4sIPx1woQH0TqLgwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ws5lw7Cc+n5PT4rpqx+JbBJsijA6CCZAfqGPLMAhXb/REFOU/ghmI5iYg6AZznOJN
	 Oq3rGyA4PxS1lg8fhOilQcmhfY7v3xpxKJNuZ1IQKEL54uKtWiXOZXeBTsfq5ZChxd
	 K1eY+z6xVgD5E/KxdqmNWGZ4nHpUjPm7GVw90xDg8YPnAfTBaxYduBo2yAoJyM/3u1
	 +vlkK/oLZbNDSEF4kmuYa6UmQq1JlqA1T59KKDY96GIw/QBYsC1kw0IVmMeAZ26zyP
	 Qzsqy+QDtCpXpOadbRpkxkDFKGCEdB92qAknxxJgVOVRrwdSIlG0hGezbSJGZtO2g+
	 1CpdnHsL/ngkg==
Date: Sun, 28 Sep 2025 11:59:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org, Angelo Compagnucci
 <angelo.compagnucci@gmail.com>
Subject: Re: [Bug 220543] New: MCP3428 scaling values are incorrect, three
 orders of magnitude low
Message-ID: <20250928115933.0a83b1bb@jic23-huawei>
In-Reply-To: <bug-220543-217253@https.bugzilla.kernel.org/>
References: <bug-220543-217253@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Sep 2025 23:42:16 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=220543
> 
>             Bug ID: 220543
>            Summary: MCP3428 scaling values are incorrect, three orders of
>                     magnitude low
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: IIO
>           Assignee: drivers_iio@kernel-bugs.kernel.org
>           Reporter: phil@munts.net
>         Regression: No
> 
> The values for in_voltageY_scale that the 6.12 kernel generates for the MCP3428
> ADC are too low by a factor of 1000.
> 
> The ADS1115 and the MCP3204 get in_voltageY_scale values around 1.0 (implying
> millivolts per ADC step) while the MCP3428 gets values around 0.001 and lower
> (implying microvolts per ADC step).
> 
> See also: https://forums.raspberrypi.com/viewtopic.php?t=391674
> 
Optimistic +CC of Angelo (it's been a few years!)

As a sanity check, if you can rebuild your driver, could you try;
diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 50834fdcf738..2bdf14f337ec 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -178,7 +178,7 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 
                *val1 = 0;
                *val2 = mcp3422_scales[sample_rate][pga];
-               return IIO_VAL_INT_PLUS_NANO;
+               return IIO_VAL_INT_PLUS_MICRO;
 
        case IIO_CHAN_INFO_SAMP_FREQ:
                *val1 = mcp3422_sample_rates[MCP3422_SAMPLE_RATE(adc->config)];

It's a bit of a hack for the largest scale as we should really represent that
as *val1 = 1, *val2 = 0 rather than *val2 = 1000000 but meh - I'll spin a nicer
fix if this works.

Working through the scaling. It's a mix of resolution, 12->18, vref = +-2.048V,
and PGA, 1->8x

The docs rather confusingly give LSB values for 12 bits of 1mV etc but those
are post PGA.   PGA increasing is equivalent of reducing the vref, so results
in lower values.

So agreed with your discovery - this seems to be out by a factor of 1000.

Thanks for the report.  Hopefully Angelo can take a look, but if not I'll try
and spin a fix. If you can test the above that would be a great start.

Thanks,

Jonathan




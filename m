Return-Path: <linux-iio+bounces-12081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2CB9C2DCF
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FA61F21512
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA97195809;
	Sat,  9 Nov 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2Xt6bWt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667914E2CC;
	Sat,  9 Nov 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731163297; cv=none; b=om5FYsbYHBOuhQVxzE9TJ0sQ5RtxNXrcyTSlSVqfzmqe4KhRN9qKA9BOXP40P5ApGP3YmXfeeRnImZ+nqN1tAZ9yezV+K11APt+iVtqPHcl7jmjBoxWFwFnyhUrFKatfhth+xfLBm4l8pIdWh9lbhbyFlkfEFbEC5xe90CfbQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731163297; c=relaxed/simple;
	bh=8xA45PajLIDr7rfRu1J8gvJ0H+nJU1IizyLP9wfSjAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpZiflEM68xuKA4g44OjS+NpJlrGJX3KBqU13ANRZN6++xNLyKIOX/g/rmWA83eJRolGwngeRxbirS68vHcvT8H1uu7fen6Gfy99KntL8SSMmN6NPLZZn/6nszgtTQbDR0EzmjerWGv0G8EUSSBlWnZZmNRPdSho45TF5VW1UQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2Xt6bWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E1AC4CECE;
	Sat,  9 Nov 2024 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731163296;
	bh=8xA45PajLIDr7rfRu1J8gvJ0H+nJU1IizyLP9wfSjAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E2Xt6bWtY46etBkbT8x5xd2IrCU39XsjNvEASRIn14lIERp/DiNc6kF/9mDSyPt/B
	 WvIe5cQg3PefaNDhxnfY/9+vABfWzU8QQ9Rom0CWLEhnGlhzIWjnatt6o7sf9Z6k01
	 S2AN2EVS9YRwnTD3UXulqajlhqAfyLLNdDxQhD3zY3qNackvcvYjNmdC7kr5LGWyjH
	 SXEm+0a5nS05po9nknqFqvC58yCnoVO0cSh5bBCAdUCCsf2WQrh4e5Zvroza52pmXv
	 f43wEugDXOxzFPgJyUwiUCRSPCUsIkQd7nEvRTIdD6U0gtYvOg67UhB7pnGJVwHUcP
	 JWO+N6/wL1eTw==
Date: Sat, 9 Nov 2024 14:41:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Zicheng Qu <quzicheng@huawei.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 daniel.baluta@intel.com, shubhrajyoti@ti.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
Subject: Re: [PATCH v2 1/2] staging: iio: ad9834: Correct phase range check
Message-ID: <20241109144126.5efb84b6@jic23-huawei>
In-Reply-To: <333c54f3-3d4b-4038-94a9-ce8396b452ce@suswa.mountain>
References: <20241105140359.2465656-1-quzicheng@huawei.com>
	<20241107011015.2472600-1-quzicheng@huawei.com>
	<20241107011015.2472600-2-quzicheng@huawei.com>
	<333c54f3-3d4b-4038-94a9-ce8396b452ce@suswa.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 13:32:42 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Thu, Nov 07, 2024 at 01:10:14AM +0000, Zicheng Qu wrote:
> > User Perspective:
> > When a user sets the phase value, the ad9834_write_phase() is called.
> > The phase register has a 12-bit resolution, so the valid range is 0 to
> > 4095. If the phase offset value of 4096 is input, it effectively exactly
> > equals 0 in the lower 12 bits, meaning no offset.
> > 
> > Reasons for the Change:
> > 1) Original Condition (phase > BIT(AD9834_PHASE_BITS)):
> > This condition allows a phase value equal to 2^12, which is 4096.
> > However, this value exceeds the valid 12-bit range, as the maximum valid
> > phase value should be 4095.
> > 2) Modified Condition (phase >= BIT(AD9834_PHASE_BITS)):
> > Ensures that the phase value is within the valid range, preventing
> > invalid datafrom being written.
> > 
> > Impact on Subsequent Logic: st->data = cpu_to_be16(addr | phase):
> > If the phase value is 2^12, i.e., 4096 (0001 0000 0000 0000), and addr
> > is AD9834_REG_PHASE0 (1100 0000 0000 0000), then addr | phase results in
> > 1101 0000 0000 0000, occupying DB12. According to the section of WRITING
> > TO A PHASE REGISTER in the datasheet, the MSB 12 PHASE0 bits should be
> > DB11. The original condition leads to incorrect DB12 usage, which
> > contradicts the datasheet and could pose potential issues for future
> > updates if DB12 is used in such related cases.
> > 
> > Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> > ---  
> 
> Fair enough.  Thanks.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Applied both patches to the fixes-togreg branch of iio.git.

Note they probably won't go upstream now until after rc1.

Thanks,

Jonathan

> 
> regards,
> dan carpenter
> 



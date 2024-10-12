Return-Path: <linux-iio+bounces-10495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 711EF99B48E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015C9B24877
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 11:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0896D198E91;
	Sat, 12 Oct 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl0reqaP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809C170A03;
	Sat, 12 Oct 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733321; cv=none; b=qGpw8ZqPKd2z/yKabeDqaQuTL6jAdfnKfXU/P5U7JB6fEPmCHRdGHmRLIvM6+d6AhTtjq7snWhnKRbgZanwWeEbnfV2NSxErDIEH1oWy3PpkaLRrQ5+uvkcXSSrwhdnFN9Tsz8iYSW2Ht7XLkkRcB/b1V4lMdMWMBzlbASvkcZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733321; c=relaxed/simple;
	bh=Y9sVZWoGEJyfMEcxUHaHTatR5Ma2wYx6ySNheqbYMWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltoeyFnJ/dZgQvwqw4LnSCELYj6IlJ2NSkJ5cbbgETHUWa7GLlNV2jN77ztjdwq4X/pFOqvP11EXrQ7g3EioSr4359llCQ1ctJMMM3mBRV6dfX/xUkUyoGbzAlYjf2aqsBOzkmoeZLPLzncoDAjyt/7ULXodU999czmjJql+n4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl0reqaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D863DC4CEC6;
	Sat, 12 Oct 2024 11:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728733321;
	bh=Y9sVZWoGEJyfMEcxUHaHTatR5Ma2wYx6ySNheqbYMWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zl0reqaPW6Vn9gQ8niyKVml3YseWRfVtjw0TCFkuQXLIMjKuft+9NjMQniU+p5X9f
	 jUu5/gVgBJDkFq6Ort9pUdeXJXvG+M/T30GIXd3NfYpsYRoBcP3Uu7f+2IBM0+ncxr
	 wJ7rvtYxULSXzHgJnl5rftIOAX7a1O1dZq0GxIXQMHI98m1W5gtrOV/szVfSaXmye1
	 V5SD9MSXSGgT8pBVP/bT+BtcdwFkoGSBOLMLP280eJNExmNbCgy+Lp/QDfWpgQ+CAy
	 a6xsety8dMCdo3xvo5nINOT8oQGv0yaR+weK8TGxzvXnzsDBkzqPeZyWHBriF2P3XC
	 PwXEltREoCTTg==
Date: Sat, 12 Oct 2024 12:41:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: Convert unsigned to unsigned int
Message-ID: <20241012124153.35614e8d@jic23-huawei>
In-Reply-To: <20241010181535.3083262-1-andriy.shevchenko@linux.intel.com>
References: <20241010181535.3083262-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 21:15:35 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Simple type conversion with no functional change implied.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

Jonathan


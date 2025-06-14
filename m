Return-Path: <linux-iio+bounces-20637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8EBAD9C93
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9822C1889E2B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9662741B3;
	Sat, 14 Jun 2025 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/ash5Pn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC771C5D4E;
	Sat, 14 Jun 2025 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749901723; cv=none; b=iRKIjcCsFv5/y9G1TmKf4EOkD21d4mW2oNJteySR37t4ynTlOQh0XcCsxqgVH/gLRnXxClXwlTF1z62t62ih+pWVKhNx3Bajq9dPJi6JAn1YEetrandjL8UGWyyCWjL0sGUrUPYhfkKjfA2KKojH6YW4nlcSrCMFwmrtMfDGvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749901723; c=relaxed/simple;
	bh=SmOaDEj2EwGdVDmk1+K6imZdiEZhNU0BJDaUw2HrJjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiQiZCB2yLKB/EVSGP3Nxp/ww89rBNXP03INsm0TLMN6QgEQDlnhxMo5bCX3ZnKsHr0czaeTdwVD44EOO93SyRlEmNqyy2/Sxbsqn1zajfvyBD2WOerjxQLCyXD2YPDJjmfT+tphuI4Y77At8s3+PeNZUxRH/cZy8+504OsmD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/ash5Pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34399C4CEEB;
	Sat, 14 Jun 2025 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749901723;
	bh=SmOaDEj2EwGdVDmk1+K6imZdiEZhNU0BJDaUw2HrJjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N/ash5PnVfbt5YhXqQ7d5r0oEkc0E2tw2e0OsMARQIoi5rC10tKyxGoDca3eZsYQj
	 5qr5vpx2AwP33WND0roFwtBwbvWp5cWWMyicgocv7iVobsNukObJofnLDK0RnwiBn8
	 SQQmiGOmBGPWyzBZ58ESQ36aPAGYKlTLLLgqMbA3dAIfU1qh07J4HjZrYTbWGJTYFd
	 HcjPtNlz9XXMjNCg989iJcGuE4vYJNH+nKd9uoXbEkxlmT+9jETnJT6AmuzB/s9gS7
	 SRqjgiNdd/7LzTuTw5z0rvAy1nSQlw8v26Ly8tCn2S3xFpSd+Lg36HyR9mH3di7pvS
	 kTZcTW+ycmoAw==
Date: Sat, 14 Jun 2025 12:48:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Ijano <andrew.ijano@gmail.com>, andrew.lopes@alumni.usp.br,
 gustavobastos@usp.br, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, jstephan@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] iio: accel: sca3000: replace error_ret labels by
 simple returns
Message-ID: <20250614124838.02b79111@jic23-huawei>
In-Reply-To: <aErOevItBLmKm4Jv@smile.fi.intel.com>
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
	<20250611194648.18133-2-andrew.lopes@alumni.usp.br>
	<aErOevItBLmKm4Jv@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 15:56:26 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jun 11, 2025 at 04:39:19PM -0300, Andrew Ijano wrote:
> > Replace usage of error_ret labels by returning directly when handling
> > errors. Cases that do a mutex unlock were not changed.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied this patch to the togreg branch of iio.git which is
initially pushed out as testing.

Thanks,

Jonathan

> 



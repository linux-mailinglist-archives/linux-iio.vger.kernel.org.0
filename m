Return-Path: <linux-iio+bounces-9016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65EB968D3C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 20:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051161C21E2C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1819CC06;
	Mon,  2 Sep 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh7TSyaM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A319CC03
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301115; cv=none; b=doPyG/nKe4QGS1Yq6aAei9AMQ+2VD8emiaAgYieCv2DL9oy1LmOu2iUuPRjMxSiHgkxOHXqGhweUhO01DBFLIVVTVHXNB+zqiSP2PbB+THnKI1Y/yRm/FhvjPCjkAIcydiOrzTi637nzNiUnDYBgZKza9VPmJK3kGTuvXCAH+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301115; c=relaxed/simple;
	bh=imfPzVFkPXFH0QJ0gEqF7JpauP2N09UqYXniMVOEA74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKihiJtwM2Dn8zrNIMHytI2S/v+LjN4+DXEaDQxlWXN/H5mrJN1aPQsVqNNvFopwp0eW4nlaqNepPZYQac0OLJ2SQDYTdb5WuVwCdz4EEn59SKwue+tlKASyeTyb9YrrxeJOAITBUR22evLmuM7PbsDsgfwsaBHTFmc9nKznpJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh7TSyaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D34C4CEC2;
	Mon,  2 Sep 2024 18:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725301114;
	bh=imfPzVFkPXFH0QJ0gEqF7JpauP2N09UqYXniMVOEA74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rh7TSyaMiwcrXgnHWrzA9loo5hvsuuX+6Ois/pU6ruqTI9rre3yv9+e1efVAv8cyE
	 0BdC6tknbDbA3dMeACVMrZ1lRKL3wNZyIL4+qsIFK3/BJX0yRfJFvfcH385/r2K4T3
	 3hUsJnl0Sd+UD/P7e9DiaRfY+PPB9/vtVBQFBRfVF0fHYMN6ruOzyYqcdLKymqI3+k
	 p3sZRNEjRqcBRyFfeaKLKPnjU8YNIvNZ7pCVonQY724/s4VMVv02tAtOkytBiIdU7s
	 iTm2iJ2TGpwJDlCzIdlfHZdTfWSORIW4E0a2vKWCX1G/HXAYk9dMtwsg2DnxtGTno0
	 Xw1PyO+Lu2iJw==
Date: Mon, 2 Sep 2024 19:18:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>, linux-iio
 <linux-iio@vger.kernel.org>
Subject: Re: Revert patch 1908f13c4682 ("iio: imu: inv_mpu6060: Remove
 duplicata code between labels")
Message-ID: <20240902191829.73b080cd@jic23-huawei>
In-Reply-To: <20240902113619.00005b83@Huawei.com>
References: <FR3P281MB1757E9B87D66EAB2512027E0CE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20240902113619.00005b83@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 11:36:19 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 2 Sep 2024 10:19:52 +0000
> Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> 
> > Hello Jonathan,
> > 
> > accepted patch 1908f13c4682 ("iio: imu: inv_mpu6050: Remove duplicata code between labels") is breaking inv_mpu6050 interrupt handling, forcing call of inv_reset_fifo() for each interrupt processing.
> > 
> > Can you revert it inside testing branch? Is there a specific standardize way of asking to revert patch or is it OK like this?
> > 
> > Thanks.
> > 
> > Best regards,
> > JB
> >   
> 
> This is fine. I'll do it when on right machine later today.
> 
> Jonathan
> 

Done.

J


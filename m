Return-Path: <linux-iio+bounces-576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D67E8034B7
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 14:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBD7280FB8
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA673250F4;
	Mon,  4 Dec 2023 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vlc9Q3HV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5B24B38
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 13:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5524C433C7;
	Mon,  4 Dec 2023 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701696299;
	bh=tQWq1wkdhLsJDO4sSOf69mI0MINSzIOOUbI44WzQSqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vlc9Q3HV3+TEhCYdYe8AJaXz0nB269R1+GwWfkLoXgIFUC1BPoaAkN9qwhKgGJexj
	 di7aLvBq8N1vYH5rnLmbuQgb+3KDf31V+L3SAlzjCUx6IisUsYa4vJekkpT57hb7+r
	 czwk7KdHksXMeUslwUja4jKb5P4Gt2cBv2O9/DGlVud6rhc63X3MZ2auUQVGtKuE+s
	 caT/LUYoyfl6HCqJYlBFz2JIDGfoCZN/m1XN/fQw6wVOzZnmwdhHunxteY3tunO8fk
	 MKYYEma6Ds3t0zmxYBe+XvDb6wavtaq48CyYn3/1RsD9wQjWTqchbSwPoiLy3ZilHG
	 kkBosByvv5PQA==
Date: Mon, 4 Dec 2023 13:24:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: proximity: irsd200: Drop unused include
Message-ID: <20231204132451.4d1790e1@jic23-huawei>
In-Reply-To: <pnd34woewec.fsf@axis.com>
References: <20231128-descriptors-iio-v1-1-da1e94755db6@linaro.org>
	<pnd34woewec.fsf@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 10:31:26 +0100
Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Tue, Nov 28, 2023 at 23:56 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > The driver includes the legacy GPIO header <linux/gpio.h> but doesn't
> > use any symbols from it. Drop it.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>  
> 
> Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>

Applied


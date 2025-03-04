Return-Path: <linux-iio+bounces-16355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A8CA4E206
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCDD189EE77
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95352702C9;
	Tue,  4 Mar 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/eWYJcJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF652641DF;
	Tue,  4 Mar 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099886; cv=none; b=ci2zLFGmBsGzR8nbAvmZwVg3CzXqFZ46D1agqZrWbYqzb311LWbg1wFOcDu5/0IQZ+Qgb780SgKrOGQvdURt7ImSfX7S2z9ud5G4cb44GnlyJzkl0bL9T1AobMS+L0TBFtEd9ib3lQyWZIEggWjCWFiWRfzfya0+jpHbmoHBTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099886; c=relaxed/simple;
	bh=gG5Cp/dvELEfgFwoOd+ks62Nuw5ztz7OeHZgm2BVqTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmB9SCOe6a6A0hhDfTkZyygYVYeaSUvSdFBrnHbvF0zJY4YAH8/JF+TGg9i4Xc9GJqlbv4/pmuzH9NeTxl5pBqLMJY+4qoHQsGUc//L+VyUKbV6EPmYI33gyh9SQR0UWwBCdYnLZJdmEpn37wn+KitAj0bcTiFx2N0ZZROW3DgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/eWYJcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EC9C4CEE9;
	Tue,  4 Mar 2025 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099886;
	bh=gG5Cp/dvELEfgFwoOd+ks62Nuw5ztz7OeHZgm2BVqTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C/eWYJcJSyz4aT3JPFK4JtCR1ilhX/ZsfhorqbXUDuaWTjVksz5w/8YkoFfPiWhTt
	 eE8SRU2TM492iTtSX93ySmTck2IwaIp1OT0YEn2aTOQaVXzLZmfCPWs2F2ay94iglY
	 AsPUaK/epqWS2+W/Qjyfi2Ou2HMiqhGBj8Ur+F8uDw+5GYNxwaloD7GQ3XeAmLuM7H
	 7q2u9oA1c1/yoMBgn09ZCOChSAxMpy7RMmKWk0ageBwBPu+B6wic3aT9EAdezxuyzE
	 hZJD09sDMQMqEjfXf5WcQMqVp0C6MAGSU09BSos1qQBQAVUIk32CaNIkTjJM8co/Mt
	 qPzKBOpeEtcwQ==
Date: Tue, 4 Mar 2025 14:51:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Kevin Tsai <ktsai@capellamicro.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: light: Fix spelling mistake "regist" ->
 "register"
Message-ID: <20250304145114.1757cec8@jic23-huawei>
In-Reply-To: <20250228090228.679535-1-colin.i.king@gmail.com>
References: <20250228090228.679535-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 09:02:28 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> There are spelling mistakes in dev_err messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
Applied.  Thanks

J


Return-Path: <linux-iio+bounces-14473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35659A15E4F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EFD3A21C5
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2E119E960;
	Sat, 18 Jan 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1bWr9XO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F119307A;
	Sat, 18 Jan 2025 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220870; cv=none; b=r7T8dtchIW8p1JFfbXPGn8GGLhnBaWelyE1zyA5mbRFhEk56GQca1HneJrT82XBUNDHoFdeqCX+2uY4hi24yUO1BiKI5kecgRHR0b1piYCzy9KRLQwpeW0De/61E+gBoQtjBbvrr6BNSceVd2qg+wtxH/FtXaWdDK7+XNU26Ai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220870; c=relaxed/simple;
	bh=2RMY/iXB8la11bj7X3ThQvw7m2PpQEUsmhleguUckkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lST2bOEJCQL6wruMlbjjadhGgQiLqwkytUPaCH+J6lod8469RDah1MXvMfYeLzjU4ir3Y8bBYKm8G1f3hfX4bLmyv7A/t35NMZTMuDXnkbeDkvPvKTUc4xyGLYRjf/NrDsvoXZBdUgMtD2gkBqiPP3DEIMtioeoQe6URGVkUZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1bWr9XO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A68C4CED1;
	Sat, 18 Jan 2025 17:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737220870;
	bh=2RMY/iXB8la11bj7X3ThQvw7m2PpQEUsmhleguUckkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j1bWr9XOozA+Jwsyr5C4vAJXwY2sQTE+zUvCJ3soJfkh9kzGWJcIUoRdsMPZC0gur
	 kRfqp+nMj0wZYQXNunN3Jw3Kq6kMh65yk7yMHjqlCmPUwZL7dNyTjb5rd3J30SIBCD
	 +jPPA1FXbhJvioYdEDd4ZTvlf6tvDtHj6uQUijzqyFDu15RKV58T5ltWeJqoX2mZB/
	 VrkJfoIg5Y6jBK7uQKZOW8E7PmqbuRRUzT6qXvUTjBe8LmCU3XVnX+HW7675I7i0L9
	 iflYsq6iSA945pgfQmZ0Pe6xuP//3fL3GCCRLpZt8jiVd0ktiVow6UddbySAhSuuWQ
	 dp/ejQdqqUR7Q==
Date: Sat, 18 Jan 2025 17:21:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: lars@metafoo.de, jstephan@baylibre.com, yasin.lee.x@gmail.com,
 dan.carpenter@linaro.org, nuno.sa@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iio-next] iio: proximity: Fix use-after-free in
 hx9023s_send_cfg()
Message-ID: <20250118172101.009fe63a@jic23-huawei>
In-Reply-To: <20250112115314.2e5ad298@jic23-huawei>
References: <20250107123510.44978-1-dheeraj.linuxdev@gmail.com>
	<20250112115314.2e5ad298@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 11:53:14 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue,  7 Jan 2025 18:05:10 +0530
> Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com> wrote:
> 
> > Reorder the assignment of fw_size to happen before release_firmware()
> > to avoid accessing the firmware structure after it's been freed.
> > 
> > Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
> > Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602791
> > Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>  
> Gah. I didn't see this until after I'd sent the pull request.
> Never mind, we have plenty of time to get this in during the rc1 cycles.
> 
> I'll queue it up after rc1.
> 
> Thanks,
> 
> Jonathan
I've now queued it but on a fixes tree I can't push out just
yet because it will make a mess of linux-next (it is ahead
of some trees that come later in the merge order for next).

Anyhow, that will all resolve during the merge window and I'll rebase
on rc1.

Thanks,

Jonathan
> 
> > ---
> >  drivers/iio/proximity/hx9023s.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> > index e092a935dbac..5aa8e5a22f32 100644
> > --- a/drivers/iio/proximity/hx9023s.c
> > +++ b/drivers/iio/proximity/hx9023s.c
> > @@ -1036,12 +1036,13 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
> >  		return -ENOMEM;
> >  
> >  	memcpy(bin->data, fw->data, fw->size);
> > -	release_firmware(fw);
> >  
> >  	bin->fw_size = fw->size;
> >  	bin->fw_ver = bin->data[FW_VER_OFFSET];
> >  	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
> >  
> > +	release_firmware(fw);
> > +
> >  	return hx9023s_bin_load(data, bin);
> >  }
> >    
> 
> 



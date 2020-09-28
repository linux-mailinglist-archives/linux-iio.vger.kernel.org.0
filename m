Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DAD27B141
	for <lists+linux-iio@lfdr.de>; Mon, 28 Sep 2020 17:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgI1Pyp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Sep 2020 11:54:45 -0400
Received: from vern.gendns.com ([98.142.107.122]:35482 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgI1Pyo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 28 Sep 2020 11:54:44 -0400
X-Greylist: delayed 1032 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 11:54:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qF6W4iDAfeSLlwl5RE77Hf5mYM9UhPw4NQBVnD2n3wQ=; b=DIiL4DBM3baH/FPhozvgjBu/OV
        SA0s+KPTgIrNXrjA/J12AVD9U/3XEQT42RbXe71Zor5E/CVsyQhqoLb420rYDmRpA46XmYRGT9Viz
        AkkGL+pmMydqNk3ngo5z/v/OP/7BUU6PO4zvGx7yiAab2e9xfNmibnsNqnWa0roPxhXXg0CdJzawI
        0RMS4sqkFpd7kW7x+cSeVuVUFsAUc2gd5WCyn4M/MRy6uG3VGG9cjlO1RzHmNPg3psG3zZlOklRnU
        DGbjh4AomJehHhUs24z/rW6FOy77Xek3SVT8A/oBslRDRZOLJRz/SB213B8it9T2YLzWJZmUtx2t/
        f3494d5g==;
Received: from [2600:1700:4830:165f::19e] (port=38396)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kMvDV-0003I5-2h; Mon, 28 Sep 2020 11:37:29 -0400
Subject: Re: [PATCH 15/18] counter: use semicolons rather than commas to
 separate statements
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
 <1601233948-11629-16-git-send-email-Julia.Lawall@inria.fr>
From:   David Lechner <david@lechnology.com>
Message-ID: <be1d59c5-fd0c-821e-0357-441c26c3d16c@lechnology.com>
Date:   Mon, 28 Sep 2020 10:37:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1601233948-11629-16-git-send-email-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/27/20 2:12 PM, Julia Lawall wrote:
> Replace commas with semicolons.  What is done is essentially described by
> the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
> 
> // <smpl>
> @@ expression e1,e2; @@
> e1
> -,
> +;
> e2
> ... when any
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
Reviewed-by: David Lechner <david@lechnology.com>


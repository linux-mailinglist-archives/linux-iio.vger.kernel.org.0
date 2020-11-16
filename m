Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC59D2B3BD0
	for <lists+linux-iio@lfdr.de>; Mon, 16 Nov 2020 04:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgKPDXY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 22:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgKPDXY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2020 22:23:24 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D89C0613CF;
        Sun, 15 Nov 2020 19:23:24 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g7so12740018pfc.2;
        Sun, 15 Nov 2020 19:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Foo/2tXglvP9Zif1hXvVi7kJEMKactK2DDmuQUb5XHM=;
        b=dq9PxKnjeGlYvTmsV/NQIySoiynG85FfugPbFg9Oa+o0G1QKuhWlQSCSt2za+uV5sD
         YToi6FYeL6/G9//TLBMpS7RXPMRysV9IDXKFv0Aq9IU77KlSG1byw7iGRvxYo9SbehmZ
         IUbUju6f615SbhoaGFtQOFsARIEWISnrhXaNTF14NUOXdyk0tXsMwA0Hw0w5vvZz8TmH
         cZ/rVMCuhdddIqscsxFQDOyPGupqvdwSZSJTQGcu72RT5Si1Iah1FqpJX2Y6LOcUYA5T
         N/SKOXGJAwerhoBvu8sdNIcogkz3RxfznMXn7n0QyMQkfHfjhogS9qqTIiQnALsQA2IY
         IMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Foo/2tXglvP9Zif1hXvVi7kJEMKactK2DDmuQUb5XHM=;
        b=NugUU/RTOH7Ene4rKQV+tRstpysR5Kjf1RcqDrgcw0nuPwDowaB+dpHzft7NqVtkdm
         TnW/xNzvA0KKOoPGQ9ZoUnSqym9Zr6/vlhuu89GV8rMQp4ti7tNnzjacqifo68ajTZnf
         8mMafCCEidVZEDP9wFZo6pbAhyZmjPdwHxg82I4410sbEgBxyXah4QmfobBLLWRm2QzO
         WZBCZbn5aaIvNaXB6KJN5k2f4a2zWoZXvS20awocnrSfkQl5eTJHwjibE0D2+FSkwmAH
         RY/kKcnhMxk4cn0AW0GahX0n891ccjA13iQ2u9WClrZaMukUu+zXT4UX4SZZjVDGx9TG
         AkQw==
X-Gm-Message-State: AOAM532JG594qwzZm621KT38x9B7MlNzOsL4CfM7OeFUFb4C/mlJygVE
        ClNICjkqpoxJ/Epl7dthTpgOmsgBqtY=
X-Google-Smtp-Source: ABdhPJwTQsFedP5yHSczuTOGnjOpp7HGvN64giTGdsYqIawifKFG0Gv48oXFa74AtO1RBc2Bw44vuQ==
X-Received: by 2002:a63:4c5:: with SMTP id 188mr11378297pge.339.1605497003956;
        Sun, 15 Nov 2020 19:23:23 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z7sm16995352pfq.214.2020.11.15.19.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 19:23:22 -0800 (PST)
Subject: Re: [PATCH 3/9] ARM: dts: Cygnus: Drop incorrect io-channel-ranges
 property.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20201115192951.1073632-1-jic23@kernel.org>
 <20201115192951.1073632-4-jic23@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <dc1680ac-28b9-872b-6ded-7c1a9bd88fdc@gmail.com>
Date:   Sun, 15 Nov 2020 19:23:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201115192951.1073632-4-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 11/15/2020 11:29 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This property applies to consumers of io-channels.  In this case we
> have a provider so the property is not used.
> 
> Not dt_schema will now detect this as an error due to a dependency
> between this property and the io-channels property.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>

Applied to devicetree/next, with the second paragraph fixed to:

"""
Recent changes to dt-schema result int his being reported as an error
as a dependency is enforced between this property and io-channels.
""""

since it did not look like a correct sentence making sense otherwise.

PS: please make sure you run get_maintainer.pl, this patch did not land
in our patchwork instance since bcm-kernel-feedback-list@broadcom.com
was not copied.

Thanks you
-- 
Florian

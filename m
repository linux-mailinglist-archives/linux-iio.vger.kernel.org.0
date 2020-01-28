Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5894214C136
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 20:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgA1TqX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 14:46:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34457 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1TqX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jan 2020 14:46:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id s144so2504608wme.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jan 2020 11:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x4otbvmTcm2XJDVA4XslEFPQzX0TpheX/16Ra4EXWrI=;
        b=jL0UIycX6Djnx6RgBBHTzbcK3seZtVicsFdkV+sH222h9hJucoY8DIf6aq7i/IRR5E
         v5p8SCka+5ICje64KxSF8pCxtFyaLMqcsSwn+YH2jW2O4ELXhPPK/sxN7CBPAr05QdQk
         mi6L+f0A/OGvrDfhheXeLMcYfjoV2AHtUR5YSWnNeoi3Hw1Z+VM2GsRBmG776HQnzPVj
         Q4AP/nMZtRL1B8rPgXSSgqeZn/lySRZ76C5bBpwXgVOspxnei6HE2t3x+sSTaXIHv+1E
         roFhJhqgmLsO9zP8EGDobw12CxUWCSigUVOR/b/OrHDUka1k/ZKiOP18SvBvW40uTGaJ
         6o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x4otbvmTcm2XJDVA4XslEFPQzX0TpheX/16Ra4EXWrI=;
        b=ryBpdgCZLX+sxWwbhpBhn5+HCdMKkdl1Hh2mjGpX1uSJH9/GkAK+USLKFRmaSsNIhp
         LZNKdZ3oMxAhcnKGjApjyH9nKMdQoY0fgPkTuAnzj3m3bYsrLTBDfOL2vpcVBcd5l7VA
         ytdrY98XSFg5QR6wZS9BiheeVa9PxI5UAYrtIh1ajGIIBaWJ3p2qSygu9KWrZ9s18axC
         NVPn9FXSg1nfSeetVhSBC1iRgdsvpBQBPfCOo9w2rWumFCBn4eheaKQutkso3mk4a53x
         XlmHNs6EY9YhUjYJnGBlKIFoL0ST11ud6IQ+LCAHqvw2mIuSqN33N9gI4GnSjlgSobqY
         lPQQ==
X-Gm-Message-State: APjAAAUEfi30hSMWw2wlaFiwK3eaVCkRfhIzVQ455942fTpg8HP/5pwe
        vxuBMiEgOAcwgp10Ghk7XjE=
X-Google-Smtp-Source: APXvYqxpqv3GuLVOzV3EqxL2VTssh4EfnUDglkfCUcKKdamR7Gt7nYRWpbZBL/FddlXX7IfPUU5jaQ==
X-Received: by 2002:a1c:b603:: with SMTP id g3mr7080100wmf.133.1580240781359;
        Tue, 28 Jan 2020 11:46:21 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id b137sm4389247wme.26.2020.01.28.11.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 11:46:20 -0800 (PST)
Subject: Re: [PATCH v2 5/7] iio: light: al3010 implement suspend support
To:     David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20200128133052.201587-1-david@ixit.cz>
 <20200128133052.201587-6-david@ixit.cz>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c06f2270-d82c-6184-3ca8-0e30667008b4@gmail.com>
Date:   Tue, 28 Jan 2020 22:46:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200128133052.201587-6-david@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

28.01.2020 16:30, David Heidelberg пишет:
> AL3010 is fairly simple chip, so for suspend is enough to disable and
> later enable it again.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/iio/light/al3010.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>

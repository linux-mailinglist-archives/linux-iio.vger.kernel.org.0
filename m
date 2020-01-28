Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5BE14C12E
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 20:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgA1TnO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 14:43:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38521 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1TnO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jan 2020 14:43:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so3901155wmj.3;
        Tue, 28 Jan 2020 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c9BMYuRcUesNngeOg5HQe/0BSagN54S3cksmusc/fyM=;
        b=jKedXVAV/JUsBFLvF0o/qlBGsVP4yVmMXILdoVURfTa7Mi36/fbnsEpiS5DCkM6uqo
         OWndF9yzZYexwsLTd+AnX+ql19wfwXjhTuxC2cKDibNFMCHeBynLIVRUo4t82lueQU+A
         pOyVgUk5BcmFSkg1I1P/uVhsWVVrOQUfNJmCch8kPNuXHmLyJtoNorDNzeOezgAxT7he
         pJuD9DjGtOk8wmpxQDUIT3raWQskBOTKdfiryqikN++18X1d7egs/6JZwv7+JNcswsTn
         AzXjormmGXENn7g8+9jVgQrSaDGSXbnKMdRuu8w25hkUvIHWC+UpUV9xayYjP9iscWCl
         n4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c9BMYuRcUesNngeOg5HQe/0BSagN54S3cksmusc/fyM=;
        b=UlL6OCwh2ysz2+aqbDGoUDmnO27ORyz5QwICwXV9prbqGNtuDIlCSowlCnP7YDtK/N
         RMBQVSaL8sJaM4Xbw+toMULoukyzJXt9vYgZGtraH6BiJRU2gTCEejw8tCHy1bO/b2TB
         HechjEWxIl5N5hnCtqHBDGRvmp5AFIQVtnaRQyzU3ABtvGwOv30JT+wqcLdatiYnPQ26
         +Th0p5RXbmWAj4MVd3ZgLIJiNM/IyZkMSyIzkd6ku5zJ+jCLO21Hn6vaVwABB/co+hX/
         7oNqHRF1lt7upgt7MBoDl1KiiAo2JCAcFshdUBzIYBC9yoLwZqrylEa/Nt488fmsVCN6
         YD+A==
X-Gm-Message-State: APjAAAXjy1zIgA52bc3OyY7814m/jBdAXGPVYkp1PzuysLS2V9lK8KRz
        kITP/3HMGgpmFiNGPfyRbwmqbhKa
X-Google-Smtp-Source: APXvYqyXHot0QERrSmQ2yzRfcMM5NwE8CiYT+S7S1vq7Q4+bnA7VdDMoOSctepR2IamcUgLoBAKWmw==
X-Received: by 2002:a1c:6246:: with SMTP id w67mr6551890wmb.141.1580240592028;
        Tue, 28 Jan 2020 11:43:12 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id g7sm26785250wrq.21.2020.01.28.11.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 11:43:11 -0800 (PST)
Subject: Re: [PATCH v2 2/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3010
To:     David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
References: <20200128133052.201587-1-david@ixit.cz>
 <20200128133052.201587-3-david@ixit.cz>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dc854734-ba4b-f558-dd6a-42da784de536@gmail.com>
Date:   Tue, 28 Jan 2020 22:43:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200128133052.201587-3-david@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

28.01.2020 16:30, David Heidelberg пишет:
> The Dyna-Image AL3010 is a 16-bit digital ambient light sensor which
> provides a multiple gain function with linear response over a dynamic
> range 1216/4863/19452/77806.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

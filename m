Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21204191BE3
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 22:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCXVYv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 17:24:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46686 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgCXVYv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 17:24:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id v16so220277ljk.13
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=alhh8KqibGsNYsTvIJ0sN0oTbHXSUSos8KQ3Gz6iRzs=;
        b=lis2lnCS1PTv5DB3Pl44vCMKFgWgUCA+SZb4Su3OGnOmLekH1+dwUr3sA0Cy3l44nk
         NU9OW0vqGY1Lq/a9L8M47WkArvdmWG72PfGWSvxtMfdbcFaZMZW0SiciABnQSNjS1tgJ
         Yu+aeNtdaGyGPsnxiadzW2WJJyQ0edmR0H7tE29bBS0m+ZlLZG7z1qRUi8x50T9Tguax
         zzyA5qBjee0q1/uWqy71Z3q23VEarkhePzFpJXeFRqDI6Z4hm/wK2rIAmyDV2KJQOTsP
         r/wu6MfcK8Qh1Lm/5ROcy31GMcUMAU6ocjdLLYyB/JKe7MpUSLLZqVNarvjgt+Umb4GL
         Yn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=alhh8KqibGsNYsTvIJ0sN0oTbHXSUSos8KQ3Gz6iRzs=;
        b=IftcEiANmehLK0NK1VN9yUs0Q0TQ5hlyFQDFHPaU6fYg2clYeHmXpcxduxwY0Q+Qcw
         pu8iJM1zIZqO4u1JSaYwIXEwqKwq8Hr4aZ5tnNAQ38WxTaV4Nw7AqK6hqSY1CB7eBzGt
         fl8FUh++b9AmELC2PtTn17VJzRhLdFhVmFYRVPqE/3sY7YUnmRq99LnTfZ9AQWS2Ge+d
         F2MvYEBjZhLUIjOZtKqic2rb3UPkoIohXxPS6iP0CVLg5YhpTsLW7AgvCXqlFIo8YSIZ
         RiG/UDw/GZxM+AKUSr0eLtTK2CtO3r0fJAl+YYWYQd8l2029LbJUKBHWwIhdFCUDbztV
         LLiQ==
X-Gm-Message-State: ANhLgQ0oTsVjQqRbFlzcTXjg9DkaKJqL3Hjz155IG7knp52SUzmhf6N/
        PWvtqLySOXx6FyTjFRYMlSj6sS5q
X-Google-Smtp-Source: ADFU+vvD7Sn3kjXKHTZmau3YSMPrb7oJoXoX3/MdxLCaIpc5jc+vuT5FHPT3l+HLFxelYPb97P85pg==
X-Received: by 2002:a2e:9284:: with SMTP id d4mr17910676ljh.226.1585085088494;
        Tue, 24 Mar 2020 14:24:48 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id v22sm2953148ljc.79.2020.03.24.14.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 14:24:48 -0700 (PDT)
Subject: Re: [PATCH v2 12/13] iio: imu: inv_mpu6050: use runtime pm with
 autosuspend
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        jic23@kernel.org, linux-iio@vger.kernel.org
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
 <20200219143958.3548-13-jmaneyrol@invensense.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e7c7dc02-bf91-9300-19c5-ce8fe16f549f@gmail.com>
Date:   Wed, 25 Mar 2020 00:24:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219143958.3548-13-jmaneyrol@invensense.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

19.02.2020 17:39, Jean-Baptiste Maneyrol пишет:
> Use runtime power management for handling chip power and
> sensor engines on/off. Simplifies things a lot since pm
> runtime already has reference counter.
> Usage of autosuspend reduces the number of power on/off. This
> makes polling interface now usable to get data at low
> frequency.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 267 ++++++++++++------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   5 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  33 ++-
>  3 files changed, 194 insertions(+), 111 deletions(-)

Hello,

This patch introduces a system suspend-resume regressing, I'm seeing the
following on entering into suspend:

 vdd_gen1v8: Underflow of regulator enable count
 inv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -22

Apparently RPM disables the regulator and then it's erroneously disabled
second time on suspend. Please fix it, thanks in advance.

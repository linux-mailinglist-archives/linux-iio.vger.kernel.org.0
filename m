Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152591AC86
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2019 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfELNxv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 May 2019 09:53:51 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41008 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfELNxv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 May 2019 09:53:51 -0400
Received: by mail-wr1-f47.google.com with SMTP id d12so12330070wrm.8
        for <linux-iio@vger.kernel.org>; Sun, 12 May 2019 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=68fs4m+Gebq4XDAvHAI3FCc8B4vyECJawLo0hiLNFmU=;
        b=loI+ENjkcbJ+RYt8/0IVn6h10Eh9emAhJaukMMjv2ai+BHFvoThy6Zfh94b+K/fHQ8
         5/3jNx7rCnB5iORh9ZqJhoIDXyyA5oXYiuXwouoHCpzARoszmd3zmA1kt5z4v2hxNSSm
         dz6atcL2IDkHRzK1uMwlgO6nbLujQv9UYZMGBndvVcr5pFIjuBZOIq9o/D6w1JYm1IQ7
         lO3JSWkh/Pm0mEXQ/4H/zgyIUUxNwle6w5IGa8GjXrL16pKCLNNWPb0cLHcw6sAOG3Hw
         HFMPc1JJCU0KN9xk+gdVOTI7OXpo4FkEgZPEz03VbYwpxkiLhl+7VsSKFeV6HmkeJxMW
         R8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=68fs4m+Gebq4XDAvHAI3FCc8B4vyECJawLo0hiLNFmU=;
        b=sVkUH0h4MHqidZBsbW9gzA8lC0qV5kMjdpRUUHEyXV2bC1ciJIAebvYeHp1SjXcYEJ
         jaPm8ilaN7cT/7OQoxt6Cn9ILqd8vnNpVGf6CgYPvX+Aw8BT+dbb5Qkbxz2lq1p3rQfS
         E6B7xtHbsrgtCA8EGU2M9H8RMIfM+qVUao4sobqsoETJg4Vv/jPPvv71ae6osAgMtviO
         qjrweTGDpntHzgfU7AskY1BQ7KNJ6e4ACIhxONpJl6fz+NlFUE2VXfmxdphatNZ2KUGC
         tsXD/i/2RYjAmNhU3036HYVukEQ35U82CGmSLv5Bh4rV0Og0pV8mdRhMGK9UU/hx8S+2
         eZng==
X-Gm-Message-State: APjAAAUoxDVyyurnxv3B/w4687NFV3lIp9ruPXH+X7P9PNfxTnNi0xRf
        xdQac+uX/CPCssm/66DFsoN5ySoz
X-Google-Smtp-Source: APXvYqwy7Yxb/DGMvYy7jpnJ/gsySJIDnqUMDnZ7zg3sBWiVndUjQsb4zPWORj8SKTuEs3sEl8POgg==
X-Received: by 2002:adf:f38a:: with SMTP id m10mr1007934wro.81.1557669228693;
        Sun, 12 May 2019 06:53:48 -0700 (PDT)
Received: from [10.0.4.6] (ip-62-235-197-37.dsl.scarlet.be. [62.235.197.37])
        by smtp.googlemail.com with ESMTPSA id l21sm9083163wmh.35.2019.05.12.06.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 06:53:47 -0700 (PDT)
Subject: Re: Buffer size for iio_push_to_buffers_with_timestamp()
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     linux-iio@vger.kernel.org
References: <affaf789-9292-20b6-010c-8cb8ef75e177@gmail.com>
 <20190511094824.5f57f6fa@archlinux>
From:   =?UTF-8?Q?Ga=c3=abtan_Carlier?= <gcembed@gmail.com>
Message-ID: <7d412499-a8d3-6074-6566-e4f99bd77f45@gmail.com>
Date:   Sun, 12 May 2019 15:53:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511094824.5f57f6fa@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: nl
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 5/11/19 10:48 AM, Jonathan Cameron wrote:
> On Thu, 9 May 2019 12:54:34 +0200
> Gaëtan Carlier <gcembed@gmail.com> wrote:
> 
>> Dear,
>>
>> I have a question about the function iio_push_to_buffers_with_timestamp().
>>
>> How kernel knows the size of the buffer ? Should the buffer always be 128 bits (with last 64 bits for timestamp) ?
> Hi Gaëtan,
> 
> All fields in IIO buffers are 'naturally' aligned and must be power of 2 size
> (8, 16, 32, 64)
> 
> This function is a bit 'odd' in that it needs a buffer that has space to insert
> the 64 bit aligned, 64 bit timestamp.
> 
> So if your devices other channels fit in 64 bits then your conclusion is
> correct.  If you have more channels then it may well be that the buffer
> is already greater than 64 bits long before leaving space for the timestamp
> and hence your buffer may need to be 192, 256 etc..
> 
Thank you for your reply.

> Hope that answers your question,
So, I still have a question. How IIO functions knows how many space is available because it handles "void *". Is the size of allocated buffer stored somewhere ?

> 
> Jonathan
> 
>>
>> Best regards,
>> Gaëtan.
> 

Best regards,
Gaëtan.

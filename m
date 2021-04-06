Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6D354FE3
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 11:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhDFJ3U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 05:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhDFJ3U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Apr 2021 05:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617701352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/tcqTrm2nF7Qd5otJiSA/0jO6p3NrpvgCRSBIQ/I8qE=;
        b=LOWGqmlwcPWCO4x1m1xkxSbqpxLHR7UNx4+zXdzmUlJLHqozGGgqWDFpUiaSeAJkw0rtmv
        TpVoyyCcCaSJV99WifnZr3QDjX/SUI+eLsEfuVD1ICH60N50ZXwFUXtrInRJUyuu24nU4e
        18Nnh3pw/Zq5iS0QU3Cb6SDdVP8Skqw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-3RYB3m6sPIiAitpk3PPbKA-1; Tue, 06 Apr 2021 05:29:10 -0400
X-MC-Unique: 3RYB3m6sPIiAitpk3PPbKA-1
Received: by mail-ej1-f71.google.com with SMTP id n21so1638991ejl.11
        for <linux-iio@vger.kernel.org>; Tue, 06 Apr 2021 02:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/tcqTrm2nF7Qd5otJiSA/0jO6p3NrpvgCRSBIQ/I8qE=;
        b=Qvly1MaLmlC2zyX+Calcj2yafpn2TIXOabgBPsZ/AXs5LDvPhUR4TEkazX04YMdL8K
         90c9aYUQ6BT6CaIuJcixWvEpkxFHRBFx5yxM/g+PVw6EMOLjcDzV07NrMFNwD+9CvSI0
         qbDCXv8fJ9AEN32cSDY6doxQ6XWNzRQ8nOkSqZsiI5zqYWqFebpZs8jZxO8nU857SX+6
         NBExCRe1IliiHksInULByX0C6NZm3DMZQHNXXR60FXWq/aWU8wBTAOMLvDvHrU0cZ8f2
         56Kn3Lru5LNT7Ojj2pbx9tNwo5TYuQAso5Yg0pOuLjeCwpoU9i514uZStNdKhfFJ94g/
         yzDg==
X-Gm-Message-State: AOAM532diLvdHurd7OIaZvKkWbdTBVeDgRuosvUVc3SjhjnP+EuHwLIF
        fS9CCalGzCztL5XTyHHmgjPv2+IIDy3o9UzkGO29Anpx8m5ibwgqGXeDMLtJ6/E2gaWtrw/kWZ9
        sRfCvv/uWadDEM3CsGlDQx6wT9ku58c04DiCAClrTJyw6VA4FbCgxG30O5GKWa3UnoIx1uP2c
X-Received: by 2002:a17:906:8470:: with SMTP id hx16mr20327990ejc.153.1617701349218;
        Tue, 06 Apr 2021 02:29:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIf9qncDO+mBcjQ+/5iPHYh7gjByISmTnITtfqoOPXK9/ZdHnnCOTqaipZMqiZkSR1MPQ2IQ==
X-Received: by 2002:a17:906:8470:: with SMTP id hx16mr20327969ejc.153.1617701349014;
        Tue, 06 Apr 2021 02:29:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id cf4sm13413248edb.19.2021.04.06.02.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 02:29:08 -0700 (PDT)
Subject: Re: [PATCH v2 resend 0/2] iio: documentation: Document
 proximity/accel sensor label use
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20210405204224.18715-1-hdegoede@redhat.com>
 <20210406094131.2fdb4d38@jic23-huawei>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <60d0b8af-8694-af84-3c38-8d68d73da1b2@redhat.com>
Date:   Tue, 6 Apr 2021 11:29:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210406094131.2fdb4d38@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 4/6/21 10:41 AM, Jonathan Cameron wrote:
> On Mon,  5 Apr 2021 22:42:22 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi Jonathan,
>>
>> AFAICT the v2 of this series is ready for merging, but I'm not seeing it here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing
> 
> It's there.  Was part of a pull request earlier this cycle I think and so
> may be somewhat buried in the history.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/Documentation/ABI/testing/sysfs-bus-iio?h=testing&id=9a6df4b1ab0e467f23ccdcbb82700cfb3eaf44a3

Good to know that it is already there.

I already was a bit surprised I couldn't find it, because I remembered you
explicitly saying that you were going to merge it. I guess I should have
searched a little bit harder before the resend, sorry about the noise.

Regards,

Hans


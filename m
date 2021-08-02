Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195A43DCEA6
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 04:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhHBCUU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 22:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhHBCUT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 22:20:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CCFC06175F
        for <linux-iio@vger.kernel.org>; Sun,  1 Aug 2021 19:20:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d1so18002953pll.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Aug 2021 19:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=GGk5TcfuiU7nc0cap9PAnor89zMyG+e4Gt9qGIGwNyU=;
        b=ASB89XCDQGYt/MaShUWBL7nqYU16/8IcpqQo+R6XUbysTQ2822h9QsWauuHfHhtD3p
         ve/F9kbhWDNowdZRBf/T3Jn/ORCTmRmGKxRbjP0tL49ysEeqltHc5Ng0lhYOCWHYFIZq
         NogpOmPGhhATvGI62/obgz+HtDkOosr4KhsDQEtNqoPorAjsE4fVlrejFR/5q2FGb8SF
         PEE2UFdgpRKgccv1iMCjHXwVVE0vH2KfakWQo4/P0xTJB+f25hFKXFpUMZYUTqtyicat
         yj/djGVJPSoNWe81BCvbA6m18MlWcyV/siE5r299Ss5Ze78cxr0CrQw8Up12sIXCnT4Z
         Oxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=GGk5TcfuiU7nc0cap9PAnor89zMyG+e4Gt9qGIGwNyU=;
        b=tbtKYRSYnphG3o2bbjPRWoTge6K7GVuARIOCAYJKTbFWmRMSyZd49o2VE1e0efYHWf
         r2ExxKhy4u3k4FXhn/k6Li5QasXBvEy+lQTjbL3eLkJNkUanPrY6Zv5aaWgkPXnL1Xjp
         KlU0DWif8zS664CHuO2TTfSBxOLH9gTfFX2H9zDYbNrFTKEVhQi+lXM+/cX9e4wFDsXS
         yBfYtHmwpcyvMJOmyktknPxmKY61WekESW/MxiwTY7X+lk+IKdQo5UMgfNWyFm6aZmam
         /iMbQq5VpfF99IIJBjw9h+brZO+FZ1B81NkMGxNKl0kgL9Li1+vZ7U7HTErQeQfiipTU
         T47Q==
X-Gm-Message-State: AOAM531AU8vZ5Ldv2IjepIOrFr9ZdmkHq5H4TgDrYQ96Ac7m1Ypueu5P
        Zk2dCXH8nMvHwx6VIJ7unJbRNQLdX45Q4A==
X-Google-Smtp-Source: ABdhPJy/jCNXOBP/6H1l9n6zyhd5VW3XUDcFi7MVzFCT0KfcGe8qMttuHkWMhTqTDuzQ8yDhlK9J2g==
X-Received: by 2002:a05:6a00:1913:b029:32b:cec0:77e5 with SMTP id y19-20020a056a001913b029032bcec077e5mr14528044pfi.76.1627870809236;
        Sun, 01 Aug 2021 19:20:09 -0700 (PDT)
Received: from ?IPv6:2604:3d09:d79:6900::439b? ([2604:3d09:d79:6900::439b])
        by smtp.gmail.com with ESMTPSA id x19sm5749864pgk.37.2021.08.01.19.20.08
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 19:20:08 -0700 (PDT)
To:     linux-iio@vger.kernel.org
From:   Morgan Hager <morgan.hager1@gmail.com>
Subject: ACPI Ambient Light Sensor Events
Message-ID: <44033d8f-c387-49d5-30c9-79a45c3b1408@gmail.com>
Date:   Sun, 1 Aug 2021 20:20:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I was thinking of extending the acpi-als driver to support reading the
colour temperature, chromaticity, polling interval, and response
table, but there's a problem with doing the response table through
IIO; the table is variable-length, but it seems that IIO channels only
support fixed-length samples (and the ACPI spec also does include a
provision for an event to be sent if the response table changes, so it
would be good to expose that to userspace rather than only allowing
reading the table from a file).

As an alternative approach, I have written a driver for personal use
which is not at all based on IIO and instead conveys events through
the ACPI netlink socket and readings directly through sysfs nodes, at
https://github.com/goose121/als_bus; this works fairly well, but it
seems that the driver was specifically migrated from something similar
to the IIO framework so that it would be compatible with other light
sensors, and it seems inelegant to use a completely different
interface for one property of a device.

Does anyone know of an elegant way these events could be exposed to
userspace, preferably one which would fit into the current framework
of the driver?

Thank you for your input,
Morgan Hager

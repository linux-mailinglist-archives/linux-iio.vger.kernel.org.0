Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99E8342A47
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 04:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCTDxP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 23:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTDwi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 23:52:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714BC061761
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 20:52:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f8so1554685pgi.9
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 20:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=iizVv7cgOcB2PaWAA1V1OQi/eLcdhQ3kgH3KbFwyRas=;
        b=wqxbcRrXpvG/7y5RMczdKSWhctvcehcb/VrRywhj3qH3q3nkcrE8tCZJUg3V9MA8y5
         O71A41cV7Hld+UlIdC4arw2Dni2IWmku076RzSnsKxMsQbJ7I7XN3HQSIF7p0o4V3BYX
         1ms4utkjWqPl4pqLscXeA3QchXK/caQIL/lqptcrFObcawAtxqKWVO6O7V1dirbZvlCc
         BzNRMIR9yqTMP3vuFDGrJ25qeWNL/mx+xoAenEAHvRxCXOTstEH37bkjojvh/mLA/nP/
         srYEf61Cx9TlaC9NFC+HMDzvV5oqXWwENnVPmmnTbJo/OLIOLgQZ95CLlobDlWNvcDVe
         b8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=iizVv7cgOcB2PaWAA1V1OQi/eLcdhQ3kgH3KbFwyRas=;
        b=SLOi91zDB/7I/TP8iT/n9h4RcsIxcLkqM5tqr1SYOkN4kGczU0eA7xhYAKaAE1FS5K
         BsBoxdJgdW7w/ZI+ZOnwT7+jWMgoQE/Xq0rbQlJyYWYk4FRJoNINcd32vH9GKOtMgVs+
         1M5EPfUfwlHVJaQlxEDkm9YQpWdL/wnAsU65euurMJ+tfNSaLtmujojhPB3OSEOqx8ZS
         lokSqfqz9v0MZAMbIl9DaQPGRlFt2c/6NoW+oV805CNb8bYBOkpnZWjxyVA9uJbEVWVm
         umOARiBH4DBwsbU0R1JYNCRV0RQkqXDpQ91DR79cACTA3avbEStT8cHweLZsv2iXWl6d
         ZSrg==
X-Gm-Message-State: AOAM53107SkJoInxDhpVmV4+G5IV4eRzmVV2CIYvLxYSxjg0UKw3vMhH
        2S99eVWzldX26MhaQRd4DRUXblnNRWZ5wQ==
X-Google-Smtp-Source: ABdhPJwDAaLBvxA0j2GjUBGktV8URamkd4d0vFvcj4/mwgmV2TVDd/0/41H4VlaCVkmMyDB7X9WPDw==
X-Received: by 2002:a62:f207:0:b029:1f6:11a4:1b81 with SMTP id m7-20020a62f2070000b02901f611a41b81mr12165951pfh.19.1616212357549;
        Fri, 19 Mar 2021 20:52:37 -0700 (PDT)
Received: from x1 ([2601:1c0:4701:ae70:af59:ed2c:fd62:84e9])
        by smtp.gmail.com with ESMTPSA id h7sm6983988pfo.45.2021.03.19.20.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 20:52:36 -0700 (PDT)
Date:   Fri, 19 Mar 2021 20:52:34 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Sean Nyekjaer <sean@geanix.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        David Lechner <david@lechnology.com>,
        linux-iio@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
Subject: iio: adc: anyone working on TI ADS7066?
Message-ID: <20210320035234.GA95301@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I have a board with a TI ADS7066 8-channel ADC [1] that I want to get
working in Linux.  I see there is already driver support in iio for
ADS1015, ADS79xx, ADS8344, ADS868x and ADS124S0x.

Is anyone already working with the ADS7066 or a similar part in that
series?

If not, I'll take one of the existing TI drivers as a template for the
ADS7066 driver.

Thank you,
Drew

[1] https://www.ti.com/product/ADS7066



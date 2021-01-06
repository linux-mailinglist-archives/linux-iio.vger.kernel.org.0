Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1282EC5A3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jan 2021 22:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbhAFVYh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jan 2021 16:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAFVYh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jan 2021 16:24:37 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4721FC061575
        for <linux-iio@vger.kernel.org>; Wed,  6 Jan 2021 13:23:57 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id n8so2475273pfa.8
        for <linux-iio@vger.kernel.org>; Wed, 06 Jan 2021 13:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=B8PYbSjV2wfSDgFPLbkumGoasg34od4IBoxCKHUJkH8=;
        b=apIUtTD+RBKMiifUBV/QOKCN1DEsE1JxgWgVOT6qWD8AmqEpUmb5loa4Kv4ZINPHLU
         c9FopF7c746VzG5HysQawa09pJBxSRVGswENI7gUizRFVTeRXnCKbN8qwo0k5DAjb9rv
         lsvzhjHh+BG75/8DjRDrJZukOkXaAGCb6bgp754HzFMLKjqVJFDE0UqT/ShNPrUdA4PB
         4iuSzObdw+PZo8089ea8QbJzgWzef1jv7jflmTDfoywyC9c1Ef8zCWvV0MWmtoE166R5
         5pH8TnwWr8lAI5IMwBvkSLDFmlGbEnNZ1CLE6G33H2TZUFmfkvxanTra2rm7849asVZe
         twhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B8PYbSjV2wfSDgFPLbkumGoasg34od4IBoxCKHUJkH8=;
        b=OD80yK+ReKVRJ2ZhM5qLlp0R71nFMHX+7QzNvo9JMXEv28DrnUCO4Twtmnz5wApkFX
         RUGZKSWMstXksQVwvfs/GjPT6fNBdAYgyY2uGJ0n0qdA2DL99Rt5WmArGIcJMr7QCRJL
         SqVHo0edI3JjwjmQb5dV8iDQz7nZGcKVfujwrojtbDHhanOQw7Sdw3z2QxC0GSLbjBfV
         8n91aGcXYhpscKODxG7uobsUcvwcMyTvdR7JbNe53PVF6wNAkdVd1BBR4OagPQMgNsq/
         mphoIoMSHfT9S7y+X3J0n9wrFdmIm3zWrZbreAFGkCTZwyFB9mO8KRRRxJewTRtGOJFS
         W6Gg==
X-Gm-Message-State: AOAM532rcUvhsHMwoDvbSWIXCOW0n5obruRJFkubWHSGFIy7Z81+7JFh
        YCEMxk1QHhlbltJaE8sVAoZ2O+hNQKpfPA==
X-Google-Smtp-Source: ABdhPJx2tCZ3UYxiwc5oOvOFVbTW/pTurKvOM6UOaZUSA/Rl1yc3ILaQ4uytOXQR7UPwTMqhs48PU+pZ6gLOtA==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a62:9208:0:b029:19e:a15f:169e with SMTP
 id o8-20020a6292080000b029019ea15f169emr5832648pfd.71.1609968236760; Wed, 06
 Jan 2021 13:23:56 -0800 (PST)
Date:   Wed,  6 Jan 2021 21:23:53 +0000
In-Reply-To: <20210106161233.GA44413@e120937-lin>
Message-Id: <20210106212353.951807-1-jbhayana@google.com>
Mime-Version: 1.0
References: <20210106161233.GA44413@e120937-lin>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: Reply to [RFC PATCH v2 0/1] Adding support for IIO SCMI based sensors
From:   Jyoti Bhayana <jbhayana@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jyoti Bhayana <jbhayana@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        egranata@google.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, Peter.hilber@opensynergy.com,
        ankitarora@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Instead of adding IIO_VAL_INT_H32_L32, I am thinking of adding IIO_VAL_FRACTIONAL_LONG
or IIO_VAL_FRACTIONAL_64 as the scale/exponent used for min/max range can be different
than the one used in resolution according to specification. 

I am planning to use read_avail for IIO_CHAN_INFO_PROCESSED using IIO_AVAIL_RANGE 
and this new IIO_VAL_FRACTIONAL_64 for min range,max range and resolution.
Instead of two values used in IIO_VAL_FRACTIONAL, IIO_VAL_FRACTIONAL_64 will use 4 values
val_high,val_low,and val2_high and val2_low.

Let me know if that is an acceptable solution.


Thanks,
Jyoti


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E852EB5F2
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jan 2021 00:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbhAEXKJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 18:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbhAEXKH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jan 2021 18:10:07 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDCFC061795
        for <linux-iio@vger.kernel.org>; Tue,  5 Jan 2021 15:09:27 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x21so450989pff.14
        for <linux-iio@vger.kernel.org>; Tue, 05 Jan 2021 15:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3QQTYrRGvdGiP5J+1ZbyRpWtam1Wq+KjywVYS8/XwHY=;
        b=k8ZE3PyggTJSgblvZ+b3RcAVjj2MHU2Nyyb7IziH8GjdhUCpsfyJanhJdL9G9qznSR
         fChz3/Qmp3sp/SGid8UwZee8wpOgQRhUEeGdVNET4CuaS/xCCHixB3Zbe2egQVvXQaVo
         YvQtche5ilHDy7x+pskv9POs4+CRGwyOS6anrvUsvGcH1RC/mPcnjsmHXFw6AKCkLhwv
         wVvMIq++8YpCC6j4yEakIrOv7RSJzC1pmvzkp/xIJaypUrjJZqevx5atcpFUgDJVMpbq
         dackgtzWSFks/uvGfdBWarA0FALhtFE9NguRoHeBaGDUx1RDG9R7F2K82fFmm1ZN+yT5
         A2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3QQTYrRGvdGiP5J+1ZbyRpWtam1Wq+KjywVYS8/XwHY=;
        b=ulDBAZSOe0cDhXJEnYHURgy+94nxEDHCLwX3K2OeX/ED6bfN8TMVvJ24w0U+K94l2P
         Pk2pWLPaP4sok4Vji1Jsk1qEb5qdzMPINcNLXwEnJ0QLb7sznyRhldMUEHFqWKcSONlr
         1pi+tSS2u8dXIzWAIEg+2hJ3z998QTmu4qS+NqkCPsoHb/6qlEAjzdpf5aJ8MwoH/MHL
         2eFP5kMVfjZNn0tzE1YIUClzWXhUXRBHxaW9EYYgOrPCKDYAS0HvV0y9XPZ8XMM/AC1n
         FDnidsIyUOr5Cd0WwFQgwuGC/3rbbMP++OOqFs6NowkT1WeZkRtbHO3NUY/shFoGVPR7
         huXg==
X-Gm-Message-State: AOAM533NmVc/tqVUzlCFWAYD1mcpO1DOhf0rOx2eI2D0CbwYZNq734RG
        7YvFWoGnUXiynTSducd+jgDLko2u2Okdzg==
X-Google-Smtp-Source: ABdhPJxvqBwvgZF6Lxv8gb5kfaOQ7GBKC23lhFfPoMF23kbDAXs8Qh+5oLmgfgduzTbZcDnQM+iIdbdSi/Z7NQ==
Sender: "jbhayana via sendgmr" <jbhayana@jbhayana.c.googlers.com>
X-Received: from jbhayana.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:42b2])
 (user=jbhayana job=sendgmr) by 2002:a17:90a:f288:: with SMTP id
 fs8mr1354336pjb.184.1609888166723; Tue, 05 Jan 2021 15:09:26 -0800 (PST)
Date:   Tue,  5 Jan 2021 23:09:20 +0000
In-Reply-To: <20201230123748.4e969f82@archlinux>
Message-Id: <20210105230920.769144-1-jbhayana@google.com>
Mime-Version: 1.0
References: <20201230123748.4e969f82@archlinux>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
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

> So, sensor_max_range can effectively be exposed as a combination of
> scale and the *_raw_avail for a raw read (via the read_avail callback in IIO).
> We'll ignore the fact the interface assumes a single value (so I assume symmetric?)

Based on the SCMI specification the sensor min range and max range are 64 bits signed number.

looks like IIO_AVAIL_RANGE can only take the following
types of data which all looks like 32 bit. IIO_VAL_FRACTIONAL
also takes two int type numbers.
How can I send 64 bit sensor range using this and read_avail callback?

#define IIO_VAL_INT 1
#define IIO_VAL_INT_PLUS_MICRO 2
#define IIO_VAL_INT_PLUS_NANO 3
#define IIO_VAL_INT_PLUS_MICRO_DB 4
#define IIO_VAL_INT_MULTIPLE 5
#define IIO_VAL_FRACTIONAL 10
#define IIO_VAL_FRACTIONAL_LOG2 11
#define IIO_VAL_CHAR 12



Thanks,
Jyoti


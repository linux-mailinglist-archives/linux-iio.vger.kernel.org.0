Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03B4CAF17
	for <lists+linux-iio@lfdr.de>; Wed,  2 Mar 2022 20:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiCBTzQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Mar 2022 14:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCBTzQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2022 14:55:16 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF30CA0E9;
        Wed,  2 Mar 2022 11:54:32 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c192so1848900wma.4;
        Wed, 02 Mar 2022 11:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=to3/ZjmhiK+v3dTFW8ACCDmEOy04qZkIAbEa9Z4dguc=;
        b=FFjnJbfRghAgeNhQMNwYSKkYF9IN1TSgsX4hBnuKa8MYH1lHeze/iMSEqwwo1XOhcP
         jZ+Vs+CmKOWi+jgvX4tA7oofpR8FoUnIyKzBJEmMTsz7BKdEJJvFNQLmkh3tluMRaWQA
         zejCHccpKf/KU5SSwkHq9yp7XPF403PhFI7KeHYoXCEnw2EPt0hkf8meMDRuA+pS4z06
         eAMZrCH5sG4OJanpqsXY3vRGlBQqJPuy8MEAsO0SJQxf5ZwSkbWXaDSc4iMwCaOoQKZc
         48SSGcgkY1Pp0LmofEfM/4d/MynLZ7RwkmpDPxz6sufmUQ2qTkbDW8fECgyi5PwCGXer
         RcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=to3/ZjmhiK+v3dTFW8ACCDmEOy04qZkIAbEa9Z4dguc=;
        b=0QYc26BVs9iWEzFRRqsHT9xYueuuTPMKu6v4YDzQwD352Dub1WBX4q0kcCc6mTeiNH
         QcHS6aNAqR/GKeWZn6cHbwe9XKwrQiopSMmRfZPjARLVZ3K20QRQdeNDKhk+02vCXO2a
         0Fozity931z2kNdYRMFqRFZIDGJFZSJxrMpAWViSpc1DCvIkVQi1bGs+6r72T8CJrfwQ
         2Ui7UNvExcawyugLOcGERdJWIhYiEP/LRenrbmV0eH9IfOMbTjfU+ZwkD0lbevJCsbc8
         XzZR5QArWQApnm94+rYf8VqAQcMcRAB2YiN8hW50ujVZ3q9mn02PaLlpPRU7h/p1DjEM
         RBFg==
X-Gm-Message-State: AOAM530NSMO/KJJBjJp/oULpBT4br4AIg/eDHM/6LLw6kgHNwk9KWUZI
        8BGKNRJ50qFpe+PBfO08d8yK8V0SYdvykA==
X-Google-Smtp-Source: ABdhPJx6GpVPTBD5kwTTCrxT/44U334tn0LTaUnYCwsbA5NiSlAqxkHleJBNdqmUcFqvdNZVqLqiSg==
X-Received: by 2002:a1c:5404:0:b0:381:6599:4620 with SMTP id i4-20020a1c5404000000b0038165994620mr1182117wmb.56.1646250870653;
        Wed, 02 Mar 2022 11:54:30 -0800 (PST)
Received: from ?IPv6:2001:a61:2a40:5b01:34db:b959:7b84:68a? ([2001:a61:2a40:5b01:34db:b959:7b84:68a])
        by smtp.gmail.com with ESMTPSA id k184-20020a1ca1c1000000b0038617ae5297sm1575136wme.33.2022.03.02.11.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:54:30 -0800 (PST)
Message-ID: <122ef1ddadd10df660e1da4f87cf416caf670335.camel@gmail.com>
Subject: Re: [PATCH v4 0/3] Add support for LTC2688
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Wed, 02 Mar 2022 20:54:29 +0100
In-Reply-To: <20220301222014.6ec90d4e@jic23-huawei>
References: <20220225130129.69-1-nuno.sa@analog.com>
         <20220227124953.02ab01fc@jic23-huawei>
         <20220301222014.6ec90d4e@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2022-03-01 at 22:20 +0000, Jonathan Cameron wrote:
> On Sun, 27 Feb 2022 12:49:53 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 25 Feb 2022 14:01:26 +0100
> > Nuno Sá <nuno.sa@analog.com> wrote:
> > 
> > Hi Nuno,
> > 
> > Given we are close to the end of this cycle and Andy has been
> > heavily involved
> > in review of this one so I want to give more time for Andy to
> > potentially take
> > another look..
> > 
> > Hence, I'm going to do something unusual and push out an extra-
> > testing branch with this
> > on so we can get through the autobuilder tests in parallel with
> > that extra time.
> > 
> > So, applied to the new extra-testing branch of iio.git with the
> > intent to apply
> > it to togreg later in a day or two subject to any last minute
> > feedback.
> 
> Given we may be very near to the cut off for the merge window (I aim
> to do a pull
> request after linux-next is out tomorrow), I've applied this to the
> togreg
> branch of iio.git and pushed it out to be picked up for linux-next.
> 

Thanks!

- Nuno Sá



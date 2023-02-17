Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F215469A49C
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 05:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBQEDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Feb 2023 23:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQEDf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2023 23:03:35 -0500
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D073B202
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 20:03:32 -0800 (PST)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-16e809949eeso3574860fac.9
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 20:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JRi4tRSy6zRd23FWaydNiS7HEvSQFffxzCA9iKLEHxM=;
        b=L0XWA0D4tE18DwGdnny9UAzGp/vsZyQ4ezWCh77+kFOPEwl3BX8bajcgRhrBPDIqkt
         mZ3LgNgVf+jdwyCdzS/mRQ6xgePT9d102V8EZG1n7TmebLXgHc+K+vMd8SLx2sgLb4+/
         r2hiWRFRKpkHxYd4AKP6tZfD8IxK0QrhO0rDbZhDkZ4EP8djvnHUK2NU4aR51/loB0SQ
         NYSPrTo+mCfuO2EiWWfws0xD+ai+llMLrO/lex6ZL6Eg2Tvpkur+jTjD6BlUeP8ZrNt+
         WHqQ3go1vTrBQXH5rz5f26B7k3wOjMO9olgkVRtcN1Le2nyPX3fP6unRJcoO0W3Tr190
         7PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRi4tRSy6zRd23FWaydNiS7HEvSQFffxzCA9iKLEHxM=;
        b=G+9iWwY933I5DphJFSmjyW3VuOOLi6oiG+mq//ME9QCqaEEytEKCKqXh3RSgNiWNxq
         1NfVkj1n8XWovyYFPpPoCj+kBv8XRqeT09Yiuj4AwEdhQ1XQ6B5llZs3nRJZV/CxLrI/
         d88olo1od8o7ez3bxVLshQxSdIThg/kIUbg7swqRCjP0GUYNRMyzUIkD+EcaJmbInnDL
         aBx77bE2JIsZLAz/BkDxHAfed23MngV5cgS2stlzq48/HW8/7pcp8xtrZcOLk4tGSX6I
         kqLHWedUa+6ps7u8aJEwhoypRFg1WmO6GPNqezblz7Q3KXEbrzTkYwnZGiaGOUjdu/Dq
         2k9w==
X-Gm-Message-State: AO0yUKW0gfX4RyykuFaXOaBDIfzEtXZF2vG3fMuWo3WRVO6uWgFQt8MQ
        8RtxWarJzFDLIgM0BO039X1P+2inkYbR5b+jGaI=
X-Google-Smtp-Source: AK7set9seAGXdpopB0WePg/aF/IPE8KRdQTHRwhdWeYSXOWFPPcwrmBxTaUa26NEikwsILrdH9wFRcbo4OMBg7t1/3s=
X-Received: by 2002:a05:6870:b492:b0:16e:369e:b9b7 with SMTP id
 y18-20020a056870b49200b0016e369eb9b7mr422063oap.7.1676606611189; Thu, 16 Feb
 2023 20:03:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:7581:b0:ea:41e2:880b with HTTP; Thu, 16 Feb 2023
 20:03:30 -0800 (PST)
From:   Hitesh lal <hiteshlal.s1973@gmail.com>
Date:   Fri, 17 Feb 2023 04:03:30 +0000
Message-ID: <CABOHdNrcnHCR=_3dtMO94UeyRALjiFMTFQzbmebahw+ko_UHgw@mail.gmail.com>
Subject: Hi
To:     hiteshlal.s1973@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Good Day,
How are you doing today? Please, I wrote to you earlier without
response from you. I have an important project that I would like to
discuss with you.
Regards  (mrgeorge.henry184@gmail.com)

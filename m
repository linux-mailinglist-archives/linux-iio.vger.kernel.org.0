Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F227D4DBB8E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Mar 2022 01:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbiCQAUX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Mar 2022 20:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiCQAUV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Mar 2022 20:20:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEEE1C930
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 17:19:05 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b189so3222833qkf.11
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 17:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=4vfQyttDdobHbBrio36ZO852PxT9+1cO/BhU8vf48uk=;
        b=pBadWm7ElG7W6NU8Ob+M2qAcyxZu2uWX6xQo81YvzoiOoACJj4exzkZP+U74rYCm6X
         tUEJnv0kX7ZJsIAM5tNJsNQwBGrbSms3sLVUKn4TeQH+LyXbzMgAhO8jXYG34lSeKQ4B
         Bv9wBOgYZOdrmN+xHyBdq7xSZFFpW/RNCGxS+6vtyagtrCRlMXdSL2RzSUSjNXoXEscu
         iW8YxcUds8zUILyyzv470QMm5CQbGn6v5kdaaFfPJfheVZ5eCI0WLu4ZdsIt4lds2f2Q
         Hx2ZHVHqWlcnIxRhMVs5J4nsqTKRRmvmYkh/1HLi6y54Qm32XjgSLedLbunEfaJ4QVVj
         J8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=4vfQyttDdobHbBrio36ZO852PxT9+1cO/BhU8vf48uk=;
        b=2W1zvKraclMaQnC0dPhgRwmDQtWB5Ei2lnDFRjgdBQ8dGmeBbgjCviFVBR35zulYE5
         YoXv8JPd1uaz9ytFg3jmaazmUMNSg/qGlPB+C4Pu/Oh7l0GGRICBx0MEzVxiscpiUEzv
         tJ+YL2HMVMyWnyd+tpHR+yv7GuYGzrCm2ZifWXjk3sJFWGVdzxymzUslzoSEhSjKvxIv
         jtqywUy07RfWIVAoSjiXgYUJ5rhv1JlSfwVCpjvLChFg1gQaS0qVT8+8sTL8GC0QbGrn
         aVcYjF4iVhfHoY+1YJsghEJnO2bqev6sJ0Ygobcmudqdd9ysPC2H147ST3qnTgM3mvzl
         9Veg==
X-Gm-Message-State: AOAM5320yxTuyxgVlXkh+Hz6ebNhNFecHbOgCpEapBo0D1wJSnXuyCyb
        /0FIARLltnmfA5XLCgzWOeMvZ1ybskCX5OdX3Y4=
X-Google-Smtp-Source: ABdhPJx1ip/4TRKuh21GE/eMQMiql59UH3ItEGXfJP/UsTEr63Y4TJYtxMy9pQ3o8QYhwDucyazMQRzPmT2pDB9LSvg=
X-Received: by 2002:a05:620a:198b:b0:67d:5ca1:c5de with SMTP id
 bm11-20020a05620a198b00b0067d5ca1c5demr1451806qkb.270.1647476344602; Wed, 16
 Mar 2022 17:19:04 -0700 (PDT)
MIME-Version: 1.0
Sender: nakodegbe@gmail.com
Received: by 2002:a05:622a:251:0:0:0:0 with HTTP; Wed, 16 Mar 2022 17:19:04
 -0700 (PDT)
From:   Hannah Johnson <hannahjohnson8856@gmail.com>
Date:   Thu, 17 Mar 2022 00:19:04 +0000
X-Google-Sender-Auth: Y6o1ckMm-4QAaIxifEuN2geSCYo
Message-ID: <CANBqjYZvB2UGD18p90ekccupLvSWoBt1fqeWw4WAdEhwc6QDqQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Hello
Nice to meet you
my name is Hannah Johnson i will be glad if we get to know each other
more better and share pictures i am  expecting your reply
thank you

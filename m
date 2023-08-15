Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A915877CE1C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 16:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbjHOOav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 10:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbjHOOa2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 10:30:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2767C199B
        for <linux-iio@vger.kernel.org>; Tue, 15 Aug 2023 07:30:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff882397ecso818145e87.3
        for <linux-iio@vger.kernel.org>; Tue, 15 Aug 2023 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692109825; x=1692714625;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zWX6sWFpbIqxvJkpqPafp4zk2BFLanx/lSJWZDELAA=;
        b=c2Xk/xKruo+2UtyP8O3IiQOmCqEUrZHadqJQZKdJ+IlEmB7glIEbbGxR1dAD1cqv0D
         SNyhmaAG7PPJOo3IGz/7Boq/5M3lRWyEYLjrElmxegpPFr92P9G15TCQKM1MeEExXYbr
         7Hxtt9+yKVMHXoslsQsH4U8tUWPGQbO5C+dUvZDilPGoKWKh/FkcHnH5ebh5Sc94CnGW
         c6nDLp9yHl2co/jWjgBkZughcl1lTDe0gEtQFcJF2EOCdjs803036+w6nHb2ugsVG/D0
         X7aTaPyFpYhhoQgqB9vQ7SmmeQ+L0pu5dEGcBVymUJZLmJi9Kg7G/QTKkq92k8Sqz5T9
         dpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109825; x=1692714625;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zWX6sWFpbIqxvJkpqPafp4zk2BFLanx/lSJWZDELAA=;
        b=kyy8rHD3IABatkb1WzXeB3ZALaqNPOynTGnCrTSQGZq0XltaGSWq3MKBPJxP3INFQY
         rlw2t5LAI/3c5X5gd8+vPstN1lf9K/Jk7H9BHJsgeSKlWZAOlS0fq2eEPFOedy15IUP+
         8xOASKtgy6jx758vHN+F4P6fBEdFgx61sUoFqh/J53yK+iT5xv4XlRws+pnRX9SD88mq
         MQLoaZ9cIlMkIs4+UcB7wJwuBJVWjzi+WBN9btaEODsmmXWmihSd89lgt0NKrC5ZryK1
         KeF8kgwJ0F/1ymEONaYlFxLWJk+qKQ0qOyti1N37cWu5Z3Nrup9g/rKROUNeUvi9sc1I
         ri0A==
X-Gm-Message-State: AOJu0YyqNja/SowOm3yM6dAMGiW+//CA2P2E300w0N9JLSYl8fs+MFvS
        lhFCRPYqVWhE96lC3BljJ8+Tt5uaOesu79OVoPM=
X-Google-Smtp-Source: AGHT+IHzFN180rJL/0i/AHjBkvTjf5cRvfdvxb8XJ20SZl872kemu8fQqFq0AAe27OnmxioLb8yxvLTuc6ukh8vIWUk=
X-Received: by 2002:a05:6512:239f:b0:4f6:47a2:7bb4 with SMTP id
 c31-20020a056512239f00b004f647a27bb4mr10384193lfv.60.1692109824458; Tue, 15
 Aug 2023 07:30:24 -0700 (PDT)
MIME-Version: 1.0
Sender: folsonterfah@gmail.com
Received: by 2002:ab2:813:0:b0:1d0:a44e:7acf with HTTP; Tue, 15 Aug 2023
 07:30:23 -0700 (PDT)
From:   Pavillion Tchi <tchi.pavillion@gmail.com>
Date:   Tue, 15 Aug 2023 14:30:23 +0000
X-Google-Sender-Auth: WngU8F2lbxG8K1LicbIhe-tfMUI
Message-ID: <CANgBfaQ8WpVRXoRedfCLwiji1nOt3k5g24fXeoyVTi+y97kiVg@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Hallo
Heb je mijn vorige e-mail ontvangen?

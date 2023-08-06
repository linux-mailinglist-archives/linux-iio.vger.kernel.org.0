Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91988771584
	for <lists+linux-iio@lfdr.de>; Sun,  6 Aug 2023 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjHFOKh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Aug 2023 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjHFOKg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Aug 2023 10:10:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD6B128
        for <linux-iio@vger.kernel.org>; Sun,  6 Aug 2023 07:10:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so6106602e87.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Aug 2023 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691331032; x=1691935832;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=EwSka9bRyZ79D15dq5B+5nLzDe2WbomQnbVHJeRZC1LzLUkYdBJsUMncT3WfK/B1+W
         jtIVi31p2yflqy03GpRThOUFpkrh9yPFVMololkiJPbiT3PvafL+TnL1wC+602kAMhiR
         wt3ZcZImtAsXI3hJmoh99iMz9SbLD4o6dhtscrT02WU1NWgv/6ctiQHWztYZU9XuZzg5
         xpQvXmyyWLnEc7kAYhVb932fyvIa/9orkLxjC3XalQzaMLk+sPwIU8/A2BLkY32ZDdW0
         v4TmHUWaRABnEql+g8Bn96zpFkQCdsT95jF4qy+qosK9iscL3P13uPuOIJOki7M89R1G
         Bsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691331032; x=1691935832;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=YBM0q4ADFnNZKCLyUJNty4Ald1/BfbI3d1Lahwu+cuC+47k9FqmB11oRzOlNGp8lDD
         JrOPRrsEZRnK2j19xoKgV42Y0otS/aD23inle/W9M9okK6iCaWPs1NYWFD9aWZ1DBJQj
         bjMtLM0JBAUDo68kHnH8zdcOIOczcRf635tEP7uYFUp7i70OcebdaFAJko5dmd8pYFWu
         T56tinkGjQjsfSZHP3nmlgB1hYasYS+rthFR3bFS2HEeBbjhUincAupL7FS68dPWJf/i
         OtaEcCAXMk4qZ2bHwDwRuOIGFTgyGPIs/qLTCWsl3/G6vgadKFOxbLz1NXJXXALBBL2m
         GGPA==
X-Gm-Message-State: AOJu0YyxGMEYVWzdHE1W0fblaaBVqKaYhCT955kgaFInYOymU98lVYhH
        FgeL3AHdK0Cn6w/aNCR9zlvsgHYZxk1eEpLGng==
X-Google-Smtp-Source: AGHT+IG8ng7e5htxY1czJ/JNEJh9rNbSxovFWZLoh/aADL43+mrpACzzItnq2Z0vPdiRZMmEdEIWJVyrLMeeXHHSPsE=
X-Received: by 2002:a05:6512:3713:b0:4f8:6ac4:84 with SMTP id
 z19-20020a056512371300b004f86ac40084mr3936002lfr.8.1691331031942; Sun, 06 Aug
 2023 07:10:31 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsanna62@gmail.com
Received: by 2002:ab3:7ad7:0:b0:239:3130:ecb6 with HTTP; Sun, 6 Aug 2023
 07:10:31 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Sun, 6 Aug 2023 07:10:31 -0700
X-Google-Sender-Auth: fStl3cE0rajaldupjsYMfe4zEmI
Message-ID: <CABLa-dr=A7i3symM7UJO9TT+48jLbvTF07GGeRjFAuc__fSj=Q@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa

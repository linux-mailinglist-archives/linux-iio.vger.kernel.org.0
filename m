Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719EA52E7AD
	for <lists+linux-iio@lfdr.de>; Fri, 20 May 2022 10:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347271AbiETIeo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 May 2022 04:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347276AbiETIeQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 May 2022 04:34:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F9F60AB6
        for <linux-iio@vger.kernel.org>; Fri, 20 May 2022 01:33:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y32so13102817lfa.6
        for <linux-iio@vger.kernel.org>; Fri, 20 May 2022 01:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=fxeNvNQP2IWeIuX/BVI3DOsHq3gFsfALDhgqW9uPjXXrObT881gN7ttPXDCPvrgw+n
         wNfmkTh6+3+JLP3ZVlBr7ZP4LCli77pVIgQZ/wvf/N3/R7NaG7K7ZIJcqkivaiqJVjWz
         i3fT8GBSmrDId9KPsQWsztQbMUTjVDzwTLqVQMPHbbrcvYh4NrirYA//a12zrh9RBbbX
         xwszvLW608E5RyWqRm7OIBzbKHI0x1oKoUhoHZETEjIBWx0j26yhFz4PXdmM5eJXuu+Y
         LRxUD9tC8J31f1EW7CxnrUFbhi9ztldopUSMfyHHSYEf3U7rUbMhj13PpckFSgmpF9dq
         Hp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=05vCA5KS2++RQVfGsOxNqBGRs3WMF9uj7cyb5SQjma+bj8uzOhxsiSWHDvatgmq+Ie
         VwXeu+NJpsTzY6pfHtPQEHxjpHF5C5nqU2S7mOmkhpOKFdwN4KuAT9s/iFS4Co9WoLaz
         ZT080TP7yHVUfdX0cizFgFu6CjBobzX+b7YPJoxGbX9bN6CC6Dw1brEPunyaNtERqSl3
         131GWLM1bhez+Oe9rq4tu4pLIbaanor5NeHQmepD5iP+EObCBSL36cw5bQjB9SWCKKsp
         kWYsKAqrREC6exxb+5koUX33y0m81m81CWhqxVSh0yM/sfnloS2iuu0YOXVa6GV9bvDa
         h0NQ==
X-Gm-Message-State: AOAM5312ww9t4FQciVOuJKJ2aQU+pKuJIppPWPId95Hw9ttDwnauBabc
        ogcOh5GURCVcywnLJ0iD9XuWTroEWan3fT+zRpM=
X-Google-Smtp-Source: ABdhPJyVZwXGq47OAzHrVPDC8cZfg2++2rkTUH8vNlXmcwI0Q7HDiCnFGFql3MNY/TkGz+ihEZOSMENFQfVZopO4qPA=
X-Received: by 2002:a05:6512:33a2:b0:478:588a:d62b with SMTP id
 i2-20020a05651233a200b00478588ad62bmr425400lfg.276.1653035629735; Fri, 20 May
 2022 01:33:49 -0700 (PDT)
MIME-Version: 1.0
Sender: dokoukomi77@gmail.com
Received: by 2002:aa6:c265:0:b0:1d0:6e73:d87d with HTTP; Fri, 20 May 2022
 01:33:49 -0700 (PDT)
From:   Julian Bikarm <jub47823@gmail.com>
Date:   Fri, 20 May 2022 08:33:49 +0000
X-Google-Sender-Auth: GUHZd4DgAZCsgM73UUEc3k-QI2c
Message-ID: <CAAB_OehM5D9sMKp5UAeuekWd8FzeoW=7dgSa2s-SHj7oLO6rFA@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian

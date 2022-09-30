Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4100A5F1063
	for <lists+linux-iio@lfdr.de>; Fri, 30 Sep 2022 19:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiI3RCA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Sep 2022 13:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiI3RB7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2022 13:01:59 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D6D10500A
        for <linux-iio@vger.kernel.org>; Fri, 30 Sep 2022 10:01:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o64so5299608oib.12
        for <linux-iio@vger.kernel.org>; Fri, 30 Sep 2022 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=lCGO2gbdisjLaROByCLhosA0uCxO3jEIlqlObdThGsY=;
        b=O6gESMTsw4UaBhcEj+5ItGzAGAmJHS4h2gotk5xkJJzBXKL2u6qoJHhndy/CJeDxvQ
         +HgwAfST0KHL8ZSP5gVuEMUB1PfDDseIgB4T6ktS23MfIXCVbyYk7w+PqsQrstG1hxnH
         StF1ZrNiOmXqdjsCKpZAyG2UE6qEh8wN8P51QAJO+Hnkm0vARtvAlVFraQl24aKqMJCE
         X2nA3CUK4gRwQuG0llf4zCwGLgFC6bdq/RAxhoHTmHeKlyBqdYY5A38UJAwqA9crVA/X
         w51RHE2pkLdT9YJO/wSM9peHDU2BJL/IxzJzHDcl6S+JHaLVpyK94M2VR6gE7AOCkBeI
         O5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lCGO2gbdisjLaROByCLhosA0uCxO3jEIlqlObdThGsY=;
        b=WydlYDNR1Aalx/SkM8ng/95hKo1FKVBCldABzG1hg7N7aRjAIw/NwhRE8H9yoMri3t
         zVnNIw0SQE7OaEQHLqkKH5xIKB+kBK4Lyp1861sFNRErcAlVd6VONNN+K0l/i6ha2U7W
         +8eKx5ceNsrTHsirL2vj78eiZ0JEFSa9ufnnVLz5GADzH5ozhpZDGNd58jrpwehAhlXI
         lvhXWqnAnfNE2nGPxFfaR0IBBJ+4DAMu5Aoj9MJ63eXfUx0i7ikmi418qIuCxnvHXHAD
         eAmII4PdPBDxDCd2WYCvJnw6YFkknPzLlpE9mnJ9cQKlHS7vleVJs2kcxPfYCbwBEdmc
         WiiQ==
X-Gm-Message-State: ACrzQf05pxAeOM0LL/Z2G6WRejr2s/LsR8QFjIjSZRN7Gz6WdTYxLbUE
        omSw3NY/PPbfQfLMWl32vjHM2pLENbwjdtMen7I=
X-Google-Smtp-Source: AMsMyM4wO1gaYkC1PYbsXROTbiYFWSr/yXIQ/koG4vgT1A5MD9P2SNN9OwnEpU2a/RvOO7dx2ysqPOnqrCmuDZCGouM=
X-Received: by 2002:a05:6808:20a1:b0:34f:8b64:9dce with SMTP id
 s33-20020a05680820a100b0034f8b649dcemr9288631oiw.185.1664557314974; Fri, 30
 Sep 2022 10:01:54 -0700 (PDT)
MIME-Version: 1.0
Reply-To: edmondpamela60@gmail.com
Sender: b.donatusbrown808@gmail.com
Received: by 2002:a05:6358:a054:b0:c7:e2b4:6260 with HTTP; Fri, 30 Sep 2022
 10:01:54 -0700 (PDT)
From:   Pamela Edmond <edmondpamela60@gmail.com>
Date:   Fri, 30 Sep 2022 17:01:54 +0000
X-Google-Sender-Auth: CmrSg8gzeId9cIAuLgoXMim9ozg
Message-ID: <CAAGWe+fQ030zSr9mmRofzgze48RAfwgFtVdny7Bopw++PhDZBw@mail.gmail.com>
Subject: Nice to meet you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I am Mrs. Pamela Edmond from Texas United States I have something very
important to tell you.

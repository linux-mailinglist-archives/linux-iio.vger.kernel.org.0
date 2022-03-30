Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F504ECE7B
	for <lists+linux-iio@lfdr.de>; Wed, 30 Mar 2022 23:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiC3Usn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Mar 2022 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiC3Usm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Mar 2022 16:48:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3D2BB2A
        for <linux-iio@vger.kernel.org>; Wed, 30 Mar 2022 13:46:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c10so25518510ejs.13
        for <linux-iio@vger.kernel.org>; Wed, 30 Mar 2022 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=liD2gfhyOXP3mhvUDL+XuWtoVfvWgJHIwpuC5U6JPEE=;
        b=BijS/zP6AymqxuQoR02gV+PGo+dpWfopPRZmJwkOHduRid3mu9hR4ccm61zJS6e+0w
         pBX6Lg4VW4dccyudcGx92+JDud0noTe+M3vSll95HuwhFPJP2QE8lYc2l4SBtqSZAen6
         AVLoEnPXLiDkTyUe4fxK2fBXaBOoYazUIfTr5z7zgG0S6A4oUgsgTeFoPwjms/sGxDVF
         VT9TAJB9uiwxDRh2NXQ//OsUBZcZ8Q8dw4IURN8s9oEsUaGQqNkte0BbFoPa3Hu2nJHA
         g8LBTVLzsLRUme/7SlUa7lrTunEr22AtHV/HXjJ+Smqg6cgk2TYdjln8jlKNAGVke/9/
         of2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=liD2gfhyOXP3mhvUDL+XuWtoVfvWgJHIwpuC5U6JPEE=;
        b=FnUURFrH7GctOZdMPMTF9uaCwU7wcq7xP5j/X+f954ZBula35ecFST7DL92s60y2NR
         ziV2fdNgsVYQZWA+1wxvCsttszXYB+B2B8UdfR/ZGRobnWNeHunZ8Fwf68TUS9hobRKV
         v6ylj8eqihRf6c141CN+gJRqfIh0D87EL0kau5hZW2p6LvjNkniQOMdyDbnTm0NWeKDV
         S7m/8DF3Z2rkqVvvg9C0xzb8Nx1yNhZHhBcUU1zWGX1dBvxOQvC0/tzXU6b+Ulx34bkq
         3R4wgBXdntvewfty0ros80rKx9gQfb7vVfQ5JL/cCSKULjUdUv686ITv9w87SwJphHUE
         LXvA==
X-Gm-Message-State: AOAM531g+LWCOQsa/bZuOlBD/Lh1vrF+1Yv3FTgdv7O8BdPgviwFasD/
        ZPf0FV25jQ9AdcMrXVfYPE7+67EIIuOD7LlQWaw=
X-Google-Smtp-Source: ABdhPJy3u2LlHi1bZ3Ou44ILnnhSIDpG885SrYRzSzOGzydktQZAsSTAjuIC0bwX2KLfu4DiWlM27UnAnbmYuOpvYQA=
X-Received: by 2002:a17:907:7ea6:b0:6db:ca53:9b0a with SMTP id
 qb38-20020a1709077ea600b006dbca539b0amr1499558ejc.763.1648673214545; Wed, 30
 Mar 2022 13:46:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:160e:0:0:0:0 with HTTP; Wed, 30 Mar 2022 13:46:53
 -0700 (PDT)
Reply-To: olejniczakk031@gmail.com
From:   Olejniczak Krzystof <amaandablessgod@gmail.com>
Date:   Wed, 30 Mar 2022 12:46:53 -0800
Message-ID: <CAPWLybxacdB6-UEGjzzHdNSwM+VrE-oiuqhEt+GZJY20xYpFSg@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Hello,

      I have a business proposal, kindly reply back for more details.

Regards

Olejniczak Krzystof Marek

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A098766ED7
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jul 2023 15:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbjG1Nya (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jul 2023 09:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjG1Ny3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jul 2023 09:54:29 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D972EDB
        for <linux-iio@vger.kernel.org>; Fri, 28 Jul 2023 06:54:28 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3464c774f23so9185275ab.1
        for <linux-iio@vger.kernel.org>; Fri, 28 Jul 2023 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690552468; x=1691157268;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H36fRyAKngZWMdCjTM5OTMeB1OrWb/HA2ZzZHUNbSFs=;
        b=In2WmBxlq3T/PLQEfUoduov5dwdU7tKhKwQXfmsTCBU9ZrRvOsc88WK1e1nzoM0JX7
         SzoPSysU9sV4hLRicwXYg+JuTd/vi3oAYCRZhE7xQV+tYx40Njz9DbD+xaMYghm2f1Ax
         0rK0MEEpbSDA8eJChvLnQ/uzndZ76meeOhdWBPV9r2BeYmSTkyqkL2p/WI51fGAxKKkm
         JDLwuNHPMDHqB+ZydvgsndMSyIMhBaHt4zjBsa3vl/gTpa3AfBoaDpDS1BCbSzLjF3hv
         aTd7J1d8hRKf7S39AegL0+ZCwfKfUdj6qZV8acNV6u5nitvzqsR5euCeQmoz9tDGhLRg
         neRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690552468; x=1691157268;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H36fRyAKngZWMdCjTM5OTMeB1OrWb/HA2ZzZHUNbSFs=;
        b=NFXaf8sR6B5+x8AJZBV0UlrjLLbptXwqFKefRmJ+63Q8vM7FyTnsH4iIEf6ZXM/+9M
         NRcFYEhxBfmZKNJR+lSnXcPk3PqF8d4sR0sw0jkJrDpTihJ6ezy+gXptp6esPpSJLs3D
         lm41dJF4yG1V7/bXwdKjRobcEMWuQ+T7P0mf7H231fYWJpT8wz2oSW2vNRw527kFIHrx
         aVh5yUWeajkl7ys/aQ0NhgpglovO0Wgatq4AgKCftaoMuwSAo1CHVokOxg4LZ6CZ5zBN
         CCakubk+Too4sp8lLYqxsRk2c8jTNjX9WYfk+PF5rGC8tWk9E1UZ+NIRRoAP+BULOPbm
         ERow==
X-Gm-Message-State: ABy/qLbokSOvbmvtYt0Cdb32Tdvxy/qV9tr2536SJe/7cl6SEVlyogAk
        l5sgcD3pvzsmes9oljm/QYsZQvUzYpvZbP1BphBSpPzKNCs=
X-Google-Smtp-Source: APBJJlEFwY8E+98UFthztWFB1ZYz3h5M4X5rR25enKT1JmKzR1Es9uKqMPV32DU/uLj6zSY5JRSRNtr2dxXUzVYJnTY=
X-Received: by 2002:a92:4b05:0:b0:345:fae5:666c with SMTP id
 m5-20020a924b05000000b00345fae5666cmr2669625ilg.4.1690552468002; Fri, 28 Jul
 2023 06:54:28 -0700 (PDT)
MIME-Version: 1.0
From:   robin getz <rgetz503@gmail.com>
Date:   Fri, 28 Jul 2023 09:54:17 -0400
Message-ID: <CAKaHzc88pv3XtAR8gWJYQqu=KJJ4mrVgbKU2ASmvbj2u==ZtYw@mail.gmail.com>
Subject: Libiio v0.25 release candidate available
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Celebrating 9 years of libiio, the userspace Library for interfacing
with Linux IIO devices (libiio)  is getting ready for a new release:
https://github.com/analogdevicesinc/libiio/releases/tag/v0.25-rc.1

Improvements:
 - improved (proper) handling for IPv6 link-local addresses
- added binaries and fixed a few macOS-13 arm64 issues
- have iiod shutdown, and reload IIO context when getting USR1 signal
- added bindings for C++11
- added some missing man pages
- fixed builds for SPARC
- and many more

If you find anything, please report to:
https://github.com/analogdevicesinc/libiio/issues

This is likely (hopefully) the last release before an upgrade to
libiio 1.0, so we would like to make sure it's as stable as possible,
as most future effort will be spent on the 1.x branch.

-Robin

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54F978CDCD
	for <lists+linux-iio@lfdr.de>; Tue, 29 Aug 2023 22:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjH2UsM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Aug 2023 16:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbjH2Urv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Aug 2023 16:47:51 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B314109
        for <linux-iio@vger.kernel.org>; Tue, 29 Aug 2023 13:47:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso7611808e87.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Aug 2023 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693342067; x=1693946867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki20NgIKQhPJbKEH+X1Ki0pzE8kY5+/jmra4p7XJ/qQ=;
        b=a+XY3DuBfdC7euBT10lsbtc8JtCgk39LiD4Ab1P10BFOQZR4KOJDqMt7+jQXb0DeKg
         ZJ907QehWxj7j0hQf9q8+rJf7RwBJgyAvxCzzCePw74im8BjCEpPxXFfAoE+cY+XbohC
         wEhfamJoW7aOHaimCCfGKRvhsWR3EPgEZvi64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693342067; x=1693946867;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki20NgIKQhPJbKEH+X1Ki0pzE8kY5+/jmra4p7XJ/qQ=;
        b=ILd7NVIzBlKIWfXKVXRyaaGKSn36U+98wto6HXtIlGrTdvN3EHTlocU0heGcVTnoJh
         fPtR9cedSqoNn4zJsi/3Jjtc4JZRTJQa+CO0jMC2yUMi8zsqYyqemWrDHOxTGCGVEzBq
         LLtOdDjKicLBt7WECge9PuC6S6psrjxZVx7+NyellBvzz7e6Yy0+M9Q3F1iDmbBzUAn2
         uLt5HJ1wgkDhzXhht0Nm1c9IgZbff6EyQxF1XXDKVqsgJm8mnjUN2Jgk9BzDrzv0WVQG
         BQD/IDgMw1ZLjaNjKO1C0vy20JI/7GS3FAT8llcBeZkjj7PbdQCUZCwdrigl/cuHfIyT
         LmpA==
X-Gm-Message-State: AOJu0YxAnZJWdDVbKqnlubCfxbwj7ezOCl77QIlvUdBg6B3LaPzt9yLq
        c09zH8gr1hNbyBHZS2sh7MO/a0gtgJGeEdusRspZaw==
X-Google-Smtp-Source: AGHT+IHvV0xjYkZ59GGkSoCx9wwb0Zm3Y6TKNWjMt1TL8chPCHnRNNl0RAggvHb9x1w+P7BNB5JUsZKz79SLnBYK+DU=
X-Received: by 2002:a19:6557:0:b0:500:aa41:9d67 with SMTP id
 c23-20020a196557000000b00500aa419d67mr50520lfj.8.1693342067249; Tue, 29 Aug
 2023 13:47:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Aug 2023 15:47:46 -0500
MIME-Version: 1.0
In-Reply-To: <20230829030622.1571852-1-tzungbi@kernel.org>
References: <20230829030622.1571852-1-tzungbi@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 29 Aug 2023 15:47:46 -0500
Message-ID: <CAE-0n50pkiQ=WO-EXmMPB_YBj6Vz1k1BkgkyqKH7BK+YpeV30g@mail.gmail.com>
Subject: Re: [PATCH v2] iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()
To:     Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, lars@metafoo.de
Cc:     chrome-platform@lists.linux.dev, gwendal@chromium.org,
        linux-iio@vger.kernel.org, dianders@chromium.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Tzung-Bi Shih (2023-08-28 20:06:22)
> cros_ec_sensors_push_data() reads `indio_dev->active_scan_mask` and
> calls iio_push_to_buffers_with_timestamp() without making sure the
> `indio_dev` stays in buffer mode.  There is a race if `indio_dev` exits
> buffer mode right before cros_ec_sensors_push_data() accesses them.
>
> An use-after-free on `indio_dev->active_scan_mask` was observed.  The
> call trace:
> [...]
>  _find_next_bit
>  cros_ec_sensors_push_data
>  cros_ec_sensorhub_event
>  blocking_notifier_call_chain
>  cros_ec_irq_thread
>
> It was caused by a race condition: one thread just freed
> `active_scan_mask` at [1]; while another thread tried to access the
> memory at [2].
>
> Fix it by calling iio_device_claim_buffer_mode() to ensure the
> `indio_dev` can't exit buffer mode during cros_ec_sensors_push_data().
>
> [1]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/industrialio-buffer.c#L1189
> [2]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c#L198
>
> Cc: stable@vger.kernel.org
> Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
